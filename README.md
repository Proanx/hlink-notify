# hlink-notify

## 使用

> [dockerhub地址](https://hub.docker.com/r/pronax/hlink-notify)

```shell
docker pull pronax/hlink-notify

docker run -d \
  -e CALLBACK_LINK=你的回调地址 \
  -v 你的下载目录:/downloads/ \
  --name=hlink-notify \
  hlink-notify
```

## 目录说明

#### /downloads

这里应该挂载你的下载目录，也是inotify的监控目录

#### /data

> 如果你不需要触发hlink后给硬链接结果777权限，那么你不需要关心这个目录

这里我用来挂载hlink硬链接过后的文件夹，也是inotify监控到事件后触发`chmod 777`的目录

因为硬链接后有些文件还是755的权限，挂载windows环境下无法修改，所以才有了这个

#### 一些可选的环境变量

|      变量名       |    默认值     | 说明                                                         |
| :---------------: | :-----------: | :----------------------------------------------------------- |
| **DEBOUNCE_TIME** |      20       | 首次触发事件后的等待时间。<br />用于防止短时间内多次写入导致频繁触发的延迟 |
|  **PERM_TIMER**   |      10       | 回调触发后给/data上777权限的等待时间**（也就是留给hlink处理新增文件的时间）** |
|  **WATCH_EVENT**  |  create,move  | inotify监控的事件类型                                        |
| **CALLBACK_LINK** |       -       | 事件触发后的回调地址                                         |
|      **TZ**       | Asia/Shanghai | 时区设置                                                     |

