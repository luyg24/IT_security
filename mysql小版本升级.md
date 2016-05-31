#mysql 小版本升级
参考：http://highdb.com/mysql-%E5%8D%87%E7%BA%A7%E8%AF%B4%E6%98%8E/
##1. 下载并安装新版本
##2. 关闭mysql，修改/etc/my.cnf的basedir信息，替换为新的路径
##3. 重启mysql，使用mysql_upgrade jinxingi检测并更新
./mysql_upgrade --host=127.0.0.1 --port=3300 /web/mysql/data/3300.sock -p
