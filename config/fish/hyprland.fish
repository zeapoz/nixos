# If running from tty1 start river
set TTY1 (tty)
[ "$TTY1" = "/dev/tty1" ] && exec wrappedhl
