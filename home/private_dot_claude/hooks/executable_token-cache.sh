#!/usr/bin/env bash
# Stop hook — sums session token usage and writes to cache file for statusline

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

TOTAL=$(python3 -c "
import json, sys

total = 0
with open(sys.argv[1]) as f:
    for line in f:
        try:
            d = json.loads(line)
            msg = d.get('message', {})
            if isinstance(msg, dict):
                u = msg.get('usage', {})
                if isinstance(u, dict):
                    total += u.get('input_tokens', 0)
                    total += u.get('output_tokens', 0)
                    total += u.get('cache_creation_input_tokens', 0)
                    total += u.get('cache_read_input_tokens', 0)
        except Exception:
            pass
print(total)
" "$SESSION_FILE" 2>/dev/null)

[ -z "$TOTAL" ] && exit 0
[ "$TOTAL" = "0" ] && exit 0

CACHE_FILE="${HOME}/.claude/.token-cache-${SESSION_ID}"
printf '%s' "$TOTAL" > "$CACHE_FILE"
