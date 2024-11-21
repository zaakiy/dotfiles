!#/bin/bash
# Get pane IDs
TOP_PANE_ID=$(tmux list-panes -F "#{pane_index} #{pane_id} #{pane_top}" | sort -nk3 | awk "NR==1 {print \$2}")
BOTTOM_PANE_ID=$(tmux list-panes -F "#{pane_index} #{pane_id} #{pane_top}" | sort -nk3 | awk "NR==2 {print \$2}")

# Fetch pane heights
TOP_PANE_HEIGHT=$(tmux display-message -p -t"$TOP_PANE_ID" "#{pane_height}")
BOTTOM_PANE_HEIGHT=$(tmux display-message -p -t"$BOTTOM_PANE_ID" "#{pane_height}")

# Calculate total and average pane heights
TOTAL_PANE_HEIGHT=$((TOP_PANE_HEIGHT + BOTTOM_PANE_HEIGHT))
AVERAGE_PANE_HEIGHT=$((TOTAL_PANE_HEIGHT / 2))

# Calculate floating-point sizes
LARGE_SIZE_FLOAT=$(echo "0.85 * $TOTAL_PANE_HEIGHT" | bc)
SMALL_SIZE_FLOAT=$(echo "0.15 * $TOTAL_PANE_HEIGHT" | bc)

# Round to nearest integers
LARGE_SIZE=$(printf "%.0f" "$LARGE_SIZE_FLOAT")
SMALL_SIZE=$(printf "%.0f" "$SMALL_SIZE_FLOAT")

if [ "$TOP_PANE_HEIGHT" -gt "$AVERAGE_PANE_HEIGHT" ]; then
    tmux resize-pane -t"$TOP_PANE_ID" -y "$SMALL_SIZE"
else
    tmux resize-pane -t"$TOP_PANE_ID" -y "$LARGE_SIZE"
fi
