mkdir mysql-init
mkdir mysql
mkdir data_xwiki
echo "grant all privileges on *.* to xwiki@'%' identified by 'xwiki'" > mysql-init/init.sql
