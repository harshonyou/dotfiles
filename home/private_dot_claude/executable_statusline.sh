#!/usr/bin/env bash
# Claude Code statusline: dir  branch  model  tokens  time

CYAN='\033[38;5;87m'
GREEN='\033[38;5;114m'
YELLOW='\033[38;5;221m'
BLUE='\033[38;5;111m'
GRAY='\033[38;5;244m'
RESET='\033[0m'

# Working dir (basename, sanitized)
DIR=$(basename "$PWD" | tr -cd 'a-zA-Z0-9._-')
[ -z "$DIR" ] && DIR="~"
printf "${CYAN} ${DIR}${RESET}"

# Git branch + dirty flag
if git -C "$PWD" rev-parse --git-dir &>/dev/null 2>&1; then
    BRANCH=$(git -C "$PWD" branch --show-current 2>/dev/null | head -c 64 | tr -cd 'a-zA-Z0-9/_.-')
    if [ -n "$BRANCH" ]; then
        DIRTY=$(git -C "$PWD" status --porcelain 2>/dev/null | head -c 1)
        if [ -n "$DIRTY" ]; then
            printf "  ${YELLOW}${BRANCH} ✦${RESET}"
        else
            printf "  ${GREEN}${BRANCH}${RESET}"
        fi
    fi
fi

# Model from session JSONL (tail last 4KB for speed)
if [ -n "$CLAUDE_CODE_SESSION_ID" ]; then
    SESSION_ID=$(printf '%s' "$CLAUDE_CODE_SESSION_ID" | tr -cd 'a-zA-Z0-9-')
    PROJECT_KEY=$(printf '%s' "$PWD" | tr '/' '-')
    SESSION_FILE="${HOME}/.claude/projects/${PROJECT_KEY}/${SESSION_ID}.jsonl"
    if [ -f "$SESSION_FILE" ] && [ ! -L "$SESSION_FILE" ]; then
        MODEL=$(tail -c 4096 "$SESSION_FILE" 2>/dev/null \
            | grep -o '"model":"[^"]*"' | tail -1 \
            | cut -d'"' -f4 \
            | tr -cd 'a-zA-Z0-9.-' \
            | sed 's/^claude-//')
        [ -n "$MODEL" ] && printf "  ${BLUE}${MODEL}${RESET}"
    fi
fi

# Token count from Stop hook cache
if [ -n "$CLAUDE_CODE_SESSION_ID" ]; then
    SESSION_ID=$(printf '%s' "$CLAUDE_CODE_SESSION_ID" | tr -cd 'a-zA-Z0-9-')
    TOKEN_CACHE="${HOME}/.claude/.token-cache-${SESSION_ID}"
    if [ -f "$TOKEN_CACHE" ] && [ ! -L "$TOKEN_CACHE" ]; then
        TOKENS=$(head -c 32 "$TOKEN_CACHE" 2>/dev/null | tr -cd '0-9')
        if [ -n "$TOKENS" ] && [ "$TOKENS" -gt 0 ] 2>/dev/null; then
            if [ "$TOKENS" -ge 1000000 ]; then
                TOKENS_FMT="$(( TOKENS / 1000000 ))M"
            elif [ "$TOKENS" -ge 1000 ]; then
                TOKENS_FMT="$(( TOKENS / 1000 ))k"
            else
                TOKENS_FMT="${TOKENS}"
            fi
            printf "  ${GRAY}${TOKENS_FMT}t${RESET}"
        fi
    fi
fi

# Time
printf "  ${GRAY}$(date +%H:%M)${RESET}\n"
