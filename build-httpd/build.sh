if [ -z "$1" ]
  then
    echo "No version argument supplied"
    exit
fi
version=$1
docker build -t httpd-ciberwiki:$version-custom --build-arg BUILD_HTTPD_VER=$version .

