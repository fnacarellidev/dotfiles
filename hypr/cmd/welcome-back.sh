#!/bin/bash

UNLOCK_TS=$(date -Iseconds)
LOCK_TS=$(systemctl --user show-environment | grep LOCK_TS | cut -d= -f2-)
SUBTITLE=$(datediff $LOCK_TS $UNLOCK_TS -f "%H hours %M minutes and %S seconds")
notify-send \
	-t 0 \
	"✨ Welcome Back $USER ✨" \
	"You've been away for $SUBTITLE"
