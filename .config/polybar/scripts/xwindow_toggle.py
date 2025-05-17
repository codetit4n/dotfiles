#!/usr/bin/env python3

import i3ipc
import subprocess

# Your monitor name
PRIMARY_MONITOR = "DP-0"

# Name of your Polybar bar and module
BAR_NAME = "mypolybar"
MODULE_NAME = "xwindow-dp0"

def send_polybar_hook(index):
    subprocess.run([
        "polybar-msg",
        "hook",
        MODULE_NAME,
        str(index)
    ])

# i3 connection
i3 = i3ipc.Connection()

def on_workspace_focus(i3, event):
    # Find which output is focused
    focused_output = None
    for output in i3.get_outputs():
        if output.focused:
            focused_output = output.name
            break

    if focused_output == PRIMARY_MONITOR:
        send_polybar_hook(0)  # show normal title
    else:
        send_polybar_hook(1)  # hide title

# Subscribe to workspace focus events
i3.on("workspace::focus", on_workspace_focus)

# Start event loop
i3.main()
