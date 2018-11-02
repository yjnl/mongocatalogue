echo stoping services
docker stop restheart
docker stop mongodb
docker rm restheart
docker rm mongodb

mkdir data
docker run -d   --name mongodb -v "$PWD/data:/data/db" -v "$PWD/import:/home" mongo:3.6 

docker  exec  mongodb mongoimport  --db myflix --collection videos --drop --file /home/videos.json
docker  exec  mongodb mongoimport --db myflix --collection categories --drop --file /home/categories.json
docker stop mongodb
docker rm mongodb
docker run -d -e MONGO_INITDB_ROOT_USERNAME='restheart' -e MONGO_INITDB_ROOT_PASSWORD='R3ste4rt!'  --name mongodb -v "$PWD/data:/data/db" -v "$PWD/import:/home" mongo:3.6 --bind_ip_all --auth

docker run -d -p 80:8080 --name restheart --link mongodb:mongodb softinstigate/restheart
