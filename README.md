# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 2.6.5

* Rails version 6.0.2.1

* Database: PostgreSQL

## Configuration

You need to run redis in specific tab

`redis-server`

You need to run sidekiq in specific tab

`sidekiq`

Database config:

* `rake db:create`
* `rake db:migrate`

Run application:

`rails server`

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

