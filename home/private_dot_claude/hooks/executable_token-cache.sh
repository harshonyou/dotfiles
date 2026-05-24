#!/usr/bin/env bash
# Stop hook — parses session JSONL and writes shell-sourceable metrics cache.
# Deduplicates by requestId (each API call emits multiple JSONL lines with identical usage).

INPUT=$(cat)

PARSED=$(printf '%s' "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('session_id', ''))
    print(d.get('cwd', ''))
except:
    print('')
    print('')
" 2>/dev/null)

SESSION_ID=$(printf '%s' "$PARSED" | sed -n '1p' | tr -cd 'a-zA-Z0-9-')
CWD=$(printf '%s' "$PARSED" | sed -n '2p' | tr -cd 'a-zA-Z0-9/._-')

[ -z "$SESSION_ID" ] && exit 0
[ -z "$CWD" ] && exit 0

PROJECT_KEY=$(printf '%s' "$CWD" | tr '/' '-')
SESSION_FILE="${HOME}/.claude/projects/${PROJECT_KEY}/${SESSION_ID}.jsonl"

[ ! -f "$SESSION_FILE" ] && exit 0
[ -L "$SESSION_FILE" ] && exit 0

CACHE_FILE="${HOME}/.claude/.token-cache-${SESSION_ID}"
TMP_FILE="${CACHE_FILE}.tmp"

python3 - "$SESSION_FILE" "$SESSION_ID" > "$TMP_FILE" <<'PYEOF'
import json, sys
from datetime import datetime, timezone

PRICING = {
    'claude-opus-4-7':   (15.0,  75.0,  18.75, 1.50),
    'claude-opus-4-5':   (15.0,  75.0,  18.75, 1.50),
    'claude-sonnet-4-6': ( 3.0,  15.0,   3.75, 0.30),
    'claude-sonnet-4-5': ( 3.0,  15.0,   3.75, 0.30),
    'claude-haiku-4-5':  ( 0.80,  4.0,   1.00, 0.08),
}
CTX_LIMIT = 200000

session_file, session_id = sys.argv[1], sys.argv[2]
model = 'claude-sonnet-4-6'
seen = {}  # requestId -> {i, o, cw, cr}  — dedup
session_start = None
session_name = ''

with open(session_file) as f:
    for line in f:
        try:
            d = json.loads(line)
            if session_start is None:
                ts = d.get('timestamp', '')
                if ts:
                    session_start = ts
            if d.get('type') == 'assistant':
                req_id = d.get('requestId') or d.get('uuid', '')
                if not req_id:
                    continue
                msg = d.get('message', {})
                m = msg.get('model', '')
                if m:
                    model = m
                if req_id not in seen:
                    u = msg.get('usage', {})
                    if isinstance(u, dict) and (u.get('input_tokens', 0) or u.get('output_tokens', 0)):
                        seen[req_id] = {
                            'i':  u.get('input_tokens', 0),
                            'o':  u.get('output_tokens', 0),
                            'cw': u.get('cache_creation_input_tokens', 0),
                            'cr': u.get('cache_read_input_tokens', 0),
                        }
            elif d.get('type') == 'user' and not d.get('isMeta') and not session_name:
                msg = d.get('message', {})
                content = msg.get('content', '')
                text = ''
                if isinstance(content, str):
                    text = content.strip()
                elif isinstance(content, list):
                    for c in content:
                        if isinstance(c, dict) and c.get('type') == 'text':
                            text = c.get('text', '').strip()
                            break
                if text and not text.startswith('<') and not text.startswith('/'):
                    session_name = ''.join(
                        ch for ch in text[:40] if ch.isalnum() or ch in " ._-"
                    ).strip()
        except Exception:
            pass

rates = PRICING.get(model, PRICING['claude-sonnet-4-6'])
pi, po, pcw, pcr = rates

ti  = sum(v['i']  for v in seen.values())
to  = sum(v['o']  for v in seen.values())
tcw = sum(v['cw'] for v in seen.values())
tcr = sum(v['cr'] for v in seen.values())

cost_cents = max(0, int((ti*pi + to*po + tcw*pcw + tcr*pcr) / 1_000_000 * 100))

total_real_input = ti + tcw + tcr
cache_ratio = int(tcr * 100 / total_real_input) if total_real_input > 0 else 0

last_u = list(seen.values())[-1] if seen else {}
last_ctx = last_u.get('i', 0) + last_u.get('cw', 0) + last_u.get('cr', 0)
context_pct = min(99, int(last_ctx * 100 / CTX_LIMIT))

session_start_epoch = 0
if session_start:
    try:
        ts = session_start.replace('Z', '+00:00')
        start_dt = datetime.fromisoformat(ts)
        session_start_epoch = int(start_dt.timestamp())
    except Exception:
        pass

print(f"MODEL='{model}'")
print(f"COST_CENTS={cost_cents}")
print(f"CACHE_RATIO={cache_ratio}")
print(f"CONTEXT_PCT={context_pct}")
print(f"TURN_COUNT={len(seen)}")
print(f"SESSION_START_EPOCH={session_start_epoch}")
print(f"SESSION_SHORT='{session_id[:6]}'")
print(f"SESSION_NAME='{session_name}'")
print(f"TOTAL_TOKENS={ti + to + tcw + tcr}")
PYEOF

[ -s "$TMP_FILE" ] && mv "$TMP_FILE" "$CACHE_FILE" || rm -f "$TMP_FILE"

afplay /System/Library/Sounds/Tink.aiff 2>/dev/null &
