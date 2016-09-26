参考：http://peiqiang.net/2016/01/20/how-to-install-elk.html
http://www.open-open.com/lib/view/open1451801542042.html
http://www.cnblogs.com/java-zhao/p/5902909.html
1. 首先安装jre
2. 下载elas，logstash，kibana的rpm安装包
3. 安装elas
使用相关：https://my.oschina.net/u/1246838/blog/353089
rpm安装即可，后面根据提示添加服务
安装插件：
/usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
/usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf
启动elasticsearch注意配置日志和数据文件的目录，一定要给elasticsearch用户写权限
4. 安装logstash
rpm安装即可，logstash.conf文件需要自己创建
5. kibana
解压源码然后运行即可
