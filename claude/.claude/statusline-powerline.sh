#!/usr/bin/env bash

input=$(cat)

RESET=$'\x1b[0m'
LEFT_ROUND=$''
RIGHT_ARROW=$''
RIGHT_ROUND=$''
DUMB_ZONE=59

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
dir_name="${cwd##*/}"
model_display=$(echo "$input" | jq -r '.model.display_name // ""')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
input_tok=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
output_tok=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0')
cache_create=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')

branch=$(git -C "$cwd" branch --show-current 2>/dev/null)

git_info=""
if [ -n "$branch" ]; then
  _gs=$(git -C "$cwd" status --porcelain 2>/dev/null)
  gs_staged=$(printf '%s' "$_gs" | grep -c '^[MADRC]')
  gs_unstaged=$(printf '%s' "$_gs" | grep -c '^.[MD]')
  gs_untracked=$(printf '%s' "$_gs" | grep -c '^??')
  git_info="S:${gs_staged} U:${gs_unstaged} A:${gs_untracked}"
fi

# "Claude Sonnet 4.6" -> "S46"
model_short=$(echo "$model_display" | sed -E 's/.*\b([A-Z])[a-z]+ ([0-9]+)\.([0-9]+).*/\1\2\3/')

if [ "$ctx_size" -gt 0 ]; then
  total=$(( input_tok + output_tok + cache_create + cache_read ))
  ctx_pct=$(( (total * 100) / ctx_size ))
else
  ctx_pct=0
fi

bg() { IFS=' ' read -r r g b <<< "$1"; printf '\x1b[48;2;%s;%s;%sm' "$r" "$g" "$b"; }
fg() { IFS=' ' read -r r g b <<< "$1"; printf '\x1b[38;2;%s;%s;%sm' "$r" "$g" "$b"; }

# Aura palette
AURA_BG="21 20 27"        # #15141b
AURA_FG="237 236 238"     # #edecee
AURA_DARK="17 15 24"      # #110f18
AURA_SURFACE="77 77 77"   # #4d4d4d
AURA_PURPLE="162 119 255" # #a277ff
AURA_TEAL="97 255 202"    # #61ffca
AURA_GREEN="163 247 191"  # #a3f7bf
AURA_YELLOW="255 202 133" # #ffca85
AURA_GOLD="255 224 102"   # #ffe066
AURA_RED="255 103 103"    # #ff6767

if [ "$ctx_pct" -gt "$DUMB_ZONE" ]; then
  ctx_bg="$AURA_RED";    ctx_fg="$AURA_DARK"
elif [ "$ctx_pct" -gt 40 ]; then
  ctx_bg="$AURA_YELLOW"; ctx_fg="$AURA_DARK"
else
  ctx_bg="$AURA_GREEN";  ctx_fg="$AURA_DARK"
fi

# "text|bg|fg"
sections=("${dir_name}|${AURA_PURPLE}|${AURA_DARK}")
[ -n "$branch" ] && sections+=("${branch}|${AURA_TEAL}|${AURA_DARK}")
[ -n "$git_info" ] && sections+=("${git_info}|${AURA_GOLD}|${AURA_DARK}")
sections+=("${model_short}|${AURA_SURFACE}|${AURA_FG}")
sections+=("󰆪 ${ctx_pct}%|${ctx_bg}|${ctx_fg}")

out=""
prev_bg=""
for i in "${!sections[@]}"; do
  IFS='|' read -r text sec_bg sec_fg <<< "${sections[$i]}"
  if [ "$i" -eq 0 ]; then
    out+="$(fg "$sec_bg")$(bg "$AURA_BG")${LEFT_ROUND}${RESET}"
    out+="$(bg "$sec_bg")$(fg "$sec_fg") ${text} ${RESET}"
  else
    out+="$(bg "$sec_bg")$(fg "$prev_bg")${RIGHT_ARROW}${RESET}"
    out+="$(bg "$sec_bg")$(fg "$sec_fg") ${text} ${RESET}"
  fi
  prev_bg="$sec_bg"
done

out+="$(fg "$prev_bg")$(bg "$AURA_BG")${RIGHT_ROUND}${RESET}"

printf '%s\n' "$out"
