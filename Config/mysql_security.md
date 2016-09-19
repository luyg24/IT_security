#mysql
##安全思路

##安全配置
1. 禁用本地文件加载
- 修改my.cnf 文件，在[mysqld] 范围内新增"local-infile=0",重启mysql即可
- 注意，在5.5以后的版本中即便新增了"local-infile=0"选项，也无法加载本地文件，需要客户端同时支持才行
- 参考"http://www.tbk.ren/article/223.html"  "http://stackoverflow.com/questions/10762239/mysql-enable-load-data-local-infile"
2. 
