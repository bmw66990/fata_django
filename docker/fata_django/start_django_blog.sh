#!/bin/bash
# 根据Dockfile创建镜像, 并且启动容器 by binbin

# 根据当前目录下的Dockerfile创建镜像
docker build -t bin/fata_django:v1 .

echo "---------Start api_leakage image---------"
# 启动django-blog容器(先mysql、再django-blog、再nginx)
# --link 链接mysql容器, 注意容器的启动顺序 在容器里面可以ping mysql
# -v 挂载共享目录, 把项目代码共享出去给后面的nginx
# -p 端口映射, 容器内的8000映射到主机的8001
# -d 后台运行
# bin/fata_django 镜像名
# 执行的命令 gunicorn安装后是在那里的
docker run --name fata_django \
--link mysql:mysql \
-v /var/www/fata_django \
-p 8001:8000 \
-d bin/fata_django:v1
# -dit bin/fata_django:v1 /bin/bash

# 进行数据库迁移, 感觉可以多写一个sh文件用于执行, 或者写到dockfile里
# docker exec fata_django python manage.py makemigrations
# docker exec fata_django python manage.py migrate
# docker exec fata_django python manage.py create_fake_data
# docker exec fata_django python manage.py collectstatic --noinput
# docker exec fata_django python manage.py compress --force

# docker exec api_leakage gunicorn binblog.wsgi --bind 0.0.0.0:8000 --daemon

echo "---------End fata_django image---------"
# 进入容器的方法 fata_django 容器名
# docker container inspect --format "{{.State.Pid}}" api_leakage
# docker inspect --format "{{.State.Pid}}" api_leakage
# 37834
#
# nsenter参数说明: http://man7.org/linux/man-pages/man1/nsenter.1.html
# nsenter --target 37834 --mount --uts --ipc --net --pid
# doing... 可以先自己在这里启动runserver看看是否通
# 退出容器
# exit