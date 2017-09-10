# README

Windows Gem Issues:
bcrypt path set to builders site, not ruby gems as ruby gems version doesn't work
tzinfo-data has platforms removed as this stops it working

OS:
Windows 10 64 bit

Ruby:
2.3.2p222

Rails:
5.1.2

Tests:
rails default

Database:
Dev - SQLite3 1.3.13 x86-mingw32, 1.3.12 x86-mingw32
Production - PostgreSQL 0.21.0 x86-mingw32, 0.20.0 x86-mingw32, 0.19.0 x86-mingw32

SQLite3 does not support arrays. For fees_received_on field in Membership table to work as intended dev needs to use PostgreSQL.

Deployment:
Deploy to Heroku 'lmc-app'

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
