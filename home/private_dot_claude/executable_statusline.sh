#!/usr/bin/env bash
# Claude Code statusline: dir │ git │ model cache ctx │ cost turns elapsed │ name │ clock

CYAN=$'\033[38;5;87m'
GREEN=$'\033[38;5;114m'
YELLOW=$'\033[38;5;221m'
BLUE=$'\033[38;5;111m'
GRAY=$'\033[38;5;244m'
RED=$'\033[38;5;203m'
MAGENTA=$'\033[38;5;183m'
RESET=$'\033[0m'
DIV="${GRAY} │ ${RESET}"

# --- Dir: ~/prefix + last 2 path components ---
HPWD="${PWD/#$HOME/~}"
DEPTH=$(printf '%s' "$HPWD" | tr -cd '/' | wc -c | tr -d ' ')
if [ "$DEPTH" -le 2 ]; then
    DIR="$HPWD"
else
    LAST2=$(printf '%s' "$HPWD" | rev | cut -d'/' -f1-2 | rev)
    [ "${HPWD:0:1}" = "~" ] && DIR="~/…/$LAST2" || DIR="…/$LAST2"
fi
printf '%s' "${CYAN} ${DIR}${RESET}"

# --- Git: branch, ahead/behind, staged/unstaged/untracked, stash ---
SEC_GIT=""
if git -C "$PWD" rev-parse --git-dir &>/dev/null 2>&1; then
    GS=$(git -C "$PWD" status --branch --porcelain=v2 2>/dev/null)
    BRANCH=$(printf '%s' "$GS" | awk '/^# branch.head / {print $3}')
    [ "$BRANCH" = "(detached)" ] && BRANCH="DETACHED"
    [ -z "$BRANCH" ] && BRANCH=$(git -C "$PWD" branch --show-current 2>/dev/null | head -c 40)

    if [ -n "$BRANCH" ]; then
        AB=$(printf '%s' "$GS" | grep '^# branch.ab ')
        AHEAD=0; BEHIND=0
        if [ -n "$AB" ]; then
            AHEAD=$(printf '%s' "$AB"  | grep -oE '\+[0-9]+' | tr -d '+')
            BEHIND=$(printf '%s' "$AB" | grep -oE '\-[0-9]+'  | tr -d '-')
            [ -z "$AHEAD" ]  && AHEAD=0
            [ -z "$BEHIND" ] && BEHIND=0
        fi

        STAGED=$(printf '%s'   "$GS" | awk '/^[12] / {if(substr($2,1,1)!=".") c++} END{print c+0}')
        UNSTAGED=$(printf '%s' "$GS" | awk '/^[12] / {if(substr($2,2,1)!=".") c++} END{print c+0}')
        UNTRACKED=$(printf '%s' "$GS" | grep -c '^? ')
        STASH=$(git -C "$PWD" stash list 2>/dev/null | wc -l | tr -d ' ')

        DIRTY=$(( STAGED + UNSTAGED + UNTRACKED ))
        [ "$DIRTY" -gt 0 ] && SEC_GIT="${YELLOW}${BRANCH}${RESET}" || SEC_GIT="${GREEN}${BRANCH}${RESET}"

        [ "$AHEAD"     -gt 0 ] 2>/dev/null && SEC_GIT+=" ${CYAN}↑${AHEAD}${RESET}"
        [ "$BEHIND"    -gt 0 ] 2>/dev/null && SEC_GIT+=" ${GRAY}↓${BEHIND}${RESET}"
        [ "$STAGED"    -gt 0 ] 2>/dev/null && SEC_GIT+=" ${YELLOW}+${STAGED}${RESET}"
        [ "$UNSTAGED"  -gt 0 ] 2>/dev/null && SEC_GIT+=" ${GRAY}~${UNSTAGED}${RESET}"
        [ "$UNTRACKED" -gt 0 ] 2>/dev/null && SEC_GIT+=" ${GRAY}?${UNTRACKED}${RESET}"
        [ "$STASH"     -gt 0 ] 2>/dev/null && SEC_GIT+=" ${GRAY}≡${STASH}${RESET}"
    fi
fi

# --- Session metrics from cache file ---
SEC_META=""   # model + cache% + ctx%
SEC_STATS=""  # cost + turns + elapsed
SEC_NAME=""   # session name
SEC_DAILY=""  # today's total cost + billing reset

# Resolve session ID: env var or latest JSONL for this project
SESSION_ID=$(printf '%s' "${CLAUDE_CODE_SESSION_ID:-}" | tr -cd 'a-zA-Z0-9-')
if [ -z "$SESSION_ID" ]; then
    PROJ_DIR="${HOME}/.claude/projects/$(printf '%s' "$PWD" | tr '/' '-')"
    LATEST=$(ls -t "$PROJ_DIR"/*.jsonl 2>/dev/null | head -1)
    [ -n "$LATEST" ] && SESSION_ID=$(basename "$LATEST" .jsonl)
fi

if [ -n "$SESSION_ID" ]; then
    CACHE_FILE="${HOME}/.claude/.token-cache-${SESSION_ID}"

    if [ -f "$CACHE_FILE" ] && [ ! -L "$CACHE_FILE" ]; then
        # shellcheck disable=SC1090
        . "$CACHE_FILE"

        # Model
        if [ -n "$MODEL" ]; then
            SHORT=$(printf '%s' "$MODEL" | sed \
                -e 's/claude-opus-4-7/O4.7/'    \
                -e 's/claude-opus-4-5/O4.5/'    \
                -e 's/claude-sonnet-4-6/S4.6/'  \
                -e 's/claude-sonnet-4-5/S4.5/'  \
                -e 's/claude-haiku-4-5.*/H4.5/' \
                -e 's/^claude-//')
            SEC_META="${BLUE}${SHORT}${RESET}"
        fi

        # Cache hit ratio
        [ "${CACHE_RATIO:-0}" -gt 0 ] 2>/dev/null && \
            SEC_META+=" ${GREEN}↻${CACHE_RATIO}%${RESET}"

        # Context window %
        if [ "${CONTEXT_PCT:-0}" -gt 0 ] 2>/dev/null; then
            if   [ "$CONTEXT_PCT" -ge 80 ]; then CTX_C="$RED"
            elif [ "$CONTEXT_PCT" -ge 60 ]; then CTX_C="$YELLOW"
            else CTX_C="$GRAY"; fi
            SEC_META+=" ${CTX_C}${CONTEXT_PCT}%ctx${RESET}"
        fi

        # Cost
        if [ "${TOTAL_TOKENS:-0}" -gt 0 ] 2>/dev/null; then
            CC="${COST_CENTS:-0}"
            if   [ "$CC" -ge 100 ] 2>/dev/null; then
                COST_FMT="\$$(( CC / 100 )).$(printf '%02d' $(( CC % 100 )))"
            elif [ "$CC" -gt 0 ] 2>/dev/null; then
                COST_FMT="${CC}¢"
            else
                COST_FMT="<1¢"
            fi
            SEC_STATS="${MAGENTA}${COST_FMT}${RESET}"
        fi

        # Turn count
        [ "${TURN_COUNT:-0}" -gt 0 ] 2>/dev/null && \
            SEC_STATS+=" ${GRAY}${TURN_COUNT}↩${RESET}"

        # Session duration (live)
        if [ "${SESSION_START_EPOCH:-0}" -gt 0 ] 2>/dev/null; then
            MINS=$(( ( $(date +%s) - SESSION_START_EPOCH ) / 60 ))
            if   [ "$MINS" -ge 60 ]; then ELAPSED_FMT="$(( MINS / 60 ))h$(( MINS % 60 ))m"
            elif [ "$MINS" -gt 0 ];  then ELAPSED_FMT="${MINS}m"
            fi
            [ -n "$ELAPSED_FMT" ] && SEC_STATS+=" ${GRAY}${ELAPSED_FMT}${RESET}"
        fi

        # Session name
        if [ -n "$SESSION_NAME" ]; then
            SNAME=$(printf '%s' "$SESSION_NAME" | head -c 20)
            [ "${#SESSION_NAME}" -gt 20 ] && SNAME="${SNAME}…"
            SEC_NAME="${GRAY}\"${SNAME}\"${RESET}"
        fi

    else
        # Fallback: read model from JSONL tail before first Stop
        PROJECT_KEY=$(printf '%s' "$PWD" | tr '/' '-')
        SESSION_FILE="${HOME}/.claude/projects/${PROJECT_KEY}/${SESSION_ID}.jsonl"
        if [ -f "$SESSION_FILE" ] && [ ! -L "$SESSION_FILE" ]; then
            MODEL_RAW=$(tail -c 4096 "$SESSION_FILE" 2>/dev/null \
                | grep -o '"model":"[^"]*"' | tail -1 \
                | cut -d'"' -f4 | tr -cd 'a-zA-Z0-9.-')
            if [ -n "$MODEL_RAW" ]; then
                SHORT=$(printf '%s' "$MODEL_RAW" | sed \
                    -e 's/claude-opus-4-7/O4.7/'    \
                    -e 's/claude-opus-4-5/O4.5/'    \
                    -e 's/claude-sonnet-4-6/S4.6/'  \
                    -e 's/claude-sonnet-4-5/S4.5/'  \
                    -e 's/claude-haiku-4-5.*/H4.5/' \
                    -e 's/^claude-//')
                SEC_META="${BLUE}${SHORT}${RESET}"
            fi
        fi
    fi
fi

# --- Daily stats: today's total cost + billing reset ---
DAILY_FILE="${HOME}/.claude/.daily-stats"
if [ -f "$DAILY_FILE" ] && [ ! -L "$DAILY_FILE" ]; then
    # shellcheck disable=SC1090
    . "$DAILY_FILE"
    if [ "${DAILY_DATE:-}" = "$(date +%Y-%m-%d)" ]; then
        [ -n "${DAILY_COST_FMT:-}" ] && SEC_DAILY="${GRAY}Σ${DAILY_COST_FMT}${RESET}"
        if [ -n "${RESET_STR:-}" ]; then
            if [ "${RESET_DAYS:-99}" -le 3 ] 2>/dev/null; then
                SEC_DAILY+=" ${YELLOW}↺${RESET_STR}${RESET}"
            else
                SEC_DAILY+=" ${GRAY}↺${RESET_STR}${RESET}"
            fi
        fi
    fi
fi

# --- Assemble with │ separators between non-empty sections ---
[ -n "$SEC_GIT"   ] && printf '%s' "${DIV}${SEC_GIT}"
[ -n "$SEC_META"  ] && printf '%s' "${DIV}${SEC_META}"
[ -n "$SEC_STATS" ] && printf '%s' "${DIV}${SEC_STATS}"
[ -n "$SEC_NAME"  ] && printf '%s' "${DIV}${SEC_NAME}"
[ -n "$SEC_DAILY" ] && printf '%s' "${DIV}${SEC_DAILY}"
printf '%s\n' "${DIV}${GRAY}$(date +%H:%M)${RESET}"
