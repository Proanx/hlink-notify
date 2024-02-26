#!/bin/sh

WATCH_DIR=/downloads  # 需要监视的目录
PERM_DIR=/data  # 需要授权的目录

perm_wait() {
    sleep $PERM_TIMER
    echo "文件授权-[$(date +"%Y-%m-%d %H:%M:%S")]"
    chmod -R 777 $PERM_DIR
}

while true; do
  change_detected=$(inotifywait -qr -e $WATCH_EVENT --format %e $WATCH_DIR)
  if [ -n "$change_detected" ]; then
    echo "文件变动-[$(date +"%Y-%m-%d %H:%M:%S")]-$change_detected"
    sleep $DEBOUNCE_TIME
    echo "触发链接-[$(date +"%Y-%m-%d %H:%M:%S")]"
    wget -qO /dev/null $CALLBACK_LINK
    perm_wait &
  fi
done

# inotifywait -mrq --format '%e' --event create,moved_to  /home/media | while read event
# do
#     echo "Detected new file: $event"
#     debounce_execute
# done