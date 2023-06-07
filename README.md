# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

https://core.telegram.org/bots/api

- create telegram bot
- brew install ngrok/ngrok/ngrok
- config/secrets.yml.example -> config/secrets.yml and add token
- launch ngrok http 3000 and register webhook https://api.telegram.org/bot6196917181:AAEPtoRN4eaZzDZcRjM7R-0dk5MoVgS6f6g/setWebhook?url=https://549d-70-34-255-104.ngrok.io/telegram
- bin/rails s
- sidekiq
