# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
- rails generate rails_icons:install --libraries=feather

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Development Docker commands
``` Bash
docker build --tag pingpong_elo_board_prod --build-arg RAILS_ENV=development .
docker run --env-file=.env --rm -p 3000:3000 pingpong_elo_board_prod
```

## `.env` content
``` Bash
PINGPONG_ELO_BOARD_DATABASE_HOST= # <add real values>
PINGPONG_ELO_BOARD_DATABASE_PORT=
PINGPONG_ELO_BOARD_DATABASE_DATABASE=
PINGPONG_ELO_BOARD_DATABASE_USERNAME=
PINGPONG_ELO_BOARD_DATABASE_PASSWORD=
```