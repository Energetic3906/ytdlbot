Fork this project from [ytdlbot](https://github.com/tgbot-collection/ytdlbot).

Setting up this project using Docker will be more convenient.
If you are not a premium user:

```shell
docker stop ytdl && docker rm ytdl && docker run --name ytdl -d -e APP_ID=<YOUR_APP_ID> -e APP_HASH=<YOUR_APP_HASH> -e TOKEN=<YOUR_TOKEN> -e ENABLE_ARIA2=True -v /root/ytdlbot/conf:/app/conf --restart=always povoma4617/ytdlbot:latest
```

If you are a premium user, first create a Python file. Then, comment out `app = Client("ytdl-main", api_id=api_id, api_hash=api_hash, bot_token=bot_token, ipv6=False)` and `app.run()`, the purpose is to create a user bot. Then, comment out `app_user = Client("my_account", api_id=api_id, api_hash=api_hash, phone_number=phone_number)`, and uncomment it later. This way, you can create a bot.

```python
from pyrogram import Client, filters
from pyrogram.types import Message

# Enter your api_id, api_hash, bot_token, and phone_number here
api_id =   # Replace with your actual api_id
api_hash = ""  # Replace with your actual api_hash
bot_token = ""  # Replace with your actual bot_token
phone_number = ""  # Replace with your actual phone number

# Create the Pyrogram client
app_user = Client("my_account", api_id=api_id, api_hash=api_hash, phone_number=phone_number)
# Later
# app_user = Client("my_account")
app = Client("ytdl-main", api_id=api_id, api_hash=api_hash, bot_token=bot_token, ipv6=False)

# Handle messages received by the bot client
@app.on_message(filters.command(["info", "i"]))
def start_command(client: Client, message: Message):
    if message.reply_to_message_id:
        # Reply to the message using the app_user client
        app_user.send_message(message.chat.id, str(message.reply_to_message))
    else:
        # Reply to the message using the app_user client
        app_user.send_message(message.chat.id, str(message.from_user))

# Start the app_user client
app_user.run()
# Later
# app_user.start()
app.run()
```

Put these two session files in a folder and also place the files from the `ytdlbot` directory of the project into that folder. Finally, use Docker:

```shell
docker stop ytdl && docker rm ytdl && docker run --name ytdl -d -e APP_ID=<YOUR_APP_ID> -e APP_HASH=<YOUR_APP_HASH> -e TOKEN=<YOUR_TOKEN> -e PREMIUM=True -e ENABLE_ARIA2=True -v /root/ytdlbot/conf:/app/conf -v /root/ytdlbot/session:/ytdlbot/ytdlbot --restart=always povoma4617/ytdlbot:latest
```

If you want to use cookies for downloading, configure using [docker-compose.yml](docker-compose.yml). For detailed configuration, refer to the YAML file.