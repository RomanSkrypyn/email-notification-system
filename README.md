# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.6.5

* Rails version 6.0.2.1

* Database: PostgreSQL

## Configuration

You need to run `foreman`

`foreman start -f Procfile.dev`

Set up Ruby dependencies, database

* `cd app`
* `./bin/setup`

How to run the test suite:

* rubocop
`rubocop -R`

* rspec
`rspec`

Rewrite schedule for sidekiq workers:

`whenever --update-crontab --set 'environment=development`

## ENV

You need to assign next variables in .env

* `DATABASE_NAME`
* `DATABASE_USER`
* `DATABASE_PASSWORD`
* `GMAIL_USER`
* `GMAIL_PASSWORD`

