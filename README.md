# docker-fml
CentOS 6, Postfix, [fml 4](http://www.fml.org/software/fml4/)
## Usage example
```
[root@cent7a ~]# docker pull ogata/docker-fml
[root@cent7a ~]# docker run -it -p 1025:25 ogata/docker-fml
[root@81173fb86174 /]# su - fml
[fml@81173fb86174 ~]$ /usr/local/fml/makefml newml elena
[fml@81173fb86174 ~]$ postalias /var/spool/ml/etc/aliases
[fml@81173fb86174 ~]$ /usr/local/fml/makefml add elena user001@hotmail.com
[fml@81173fb86174 ~]$ /usr/local/fml/makefml add elena user002@gmail.com
[fml@81173fb86174 ~]$ /usr/local/fml/makefml add elena user003@yahoo.co.jp
[fml@81173fb86174 ~]$ tail -f /var/spool/ml/elena/log
```
