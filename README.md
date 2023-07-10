Fork this project from [ytdlbot](https://github.com/tgbot-collection/ytdlbot). 

It will be more convenient to set up this project using Docker.

```
docker stop ytdl && docker rm ytdl && docker run --name ytdl -d -e APP_ID=<YOUR_APP_ID> -e APP_HASH=<YOUR_APP_HASH> -e TOKEN=<YOUR_TOKEN> -e ENABLE_ARIA2=True -v /root/ytdlbot/conf:/app/conf --restart=always povoma4617/ytdlbot:latest
```
