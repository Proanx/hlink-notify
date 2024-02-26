FROM alpine:latest

# 防抖等待时间
ENV DEBOUNCE_TIME=20    
# 授权等待时间
ENV PERM_TIMER=10
# inotify监控事件
ENV WATCH_EVENT=create,move
# 回调链接
ENV CALLBACK_LINK=tower:15460/api/task/run?name=Pt&alive=0
# 时区
ENV TZ=Asia/Shanghai

RUN mkdir /downloads
RUN mkdir /data

WORKDIR /script

RUN apk update \
    && apk add inotify-tools \
    && apk add tzdata

# 时区
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY monitor.sh .

ENTRYPOINT ["./monitor.sh"]
# CMD ["sh", "-c", "while true; do sleep 1; done"]