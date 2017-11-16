docker run -d --name mongodb -v "$PWD/data:/data/db" -v "$PWD/import:/home" mongo:3.0
docker  exec  mongodb mongoimport --db myflix --collection videos --drop --file /home/videos.json
docker  exec  mongodb mongoimport --db myflix --collection categories --drop --file /home/categories.json
docker run -d -p 80:8080 --name restheart --link mongodb:mongodb softinstigate/restheart
