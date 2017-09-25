#!/usr/bin/env bash

session=egi-datahub-org-onezone
window=all-nodes
pane=${session}:${window}
tmux new-session -s "$session" \
	-n "$window" -d '/usr/bin/env bash -l'\; \
    split-window -d '/usr/bin/env bash -l'\; \
    split-window -d '/usr/bin/env bash -l'\; \
    select-layout tiled\; \
	send-keys -t "${pane}.1" C-z 'ssh ubuntu@datahub.plgrid.pl' Enter\; \
	send-keys -t "${pane}.2" C-z 'ssh ubuntu@datahubdb01.plgrid.pl' Enter\; \
	send-keys -t "${pane}.3" C-z 'ssh ubuntu@datahubdb02.plgrid.pl' Enter\; \
	bind b set-window-option synchronize-panes\; \
    attach-session%