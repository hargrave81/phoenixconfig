docker run --name mysql -v /db:/var/lib/mysql --restart=always -e MYSQL_ROOT_PASSWORD=SOMEREALLyr00tpwd -e MYSQL_DATABASE=dspdb -e MYSQL_USER=ffxi -e MYSQL_PASSWORD=Squareenix81 -p 3309:3306 -d mysql:5.7

apt-get update && \
apt-get install -y git-core rsync && \
mkdir /darkstar
git clone http://github.com/hargrave81/darkstar /darkstar
git clone http://github.com/hargrave81/darkstar /darkstar/sql2
rsync -avh /darkstar/sql2/sql/* /darkstar/sql && \
for i in /darkstar/sql/*.sql ; do mysql dspdb -h localhost -u ffxi -pSquareenix81 < "$i"; done
echo "done"
rm -rf /darkstar