#!/usr/bin/env bash

session=egi-datahub-org-onezone
window=all-nodes
pane=${session}:${window}
tmux new-session -s "$session" \
	-n "$window" -d '/usr/bin/env bash -l'\; \
    split-window -d '/usr/bin/env bash -l'\; \
    split-window -d '/usr/bin/env bash -l'\; \
    split-window -d '/usr/bin/env bash -l'\; \
    select-layout tiled\; \
	send-keys -t "${pane}.0" C-z 'ssh ubuntu@onedata00.cloud.plgrid.pl' Enter\; \
	send-keys -t "${pane}.1" C-z 'ssh ubuntu@onedata01.cloud.plgrid.pl' Enter\; \
	send-keys -t "${pane}.2" C-z 'ssh ubuntu@zonedb01.cloud.plgrid.pl' Enter\; \
	send-keys -t "${pane}.3" C-z 'ssh ubuntu@zonedb02.cloud.plgrid.pl' Enter\; \
	bind b set-window-option synchronize-panes\; \
    attach-session