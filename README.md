# README

## Dependencies

- Ruby: 2.6.6
- Rails: 5.1.7
- Postgres (production)
- SQLite3 (development, test)

## Setup

- install gems with `bundle install`
- `rails s` to run server on localhost:3000

## Database

- `rails db:drop`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`

## Testing

- `rails test` runs the test suite with minitest
- run `rails db:fixtures:load RAILS_ENV=test` if fixtures have been changed
- specify `RAILS_ENV=test` when using database functions

## Deployment

- `rake assets:precompile RAILS_ENV=production` is necessary before pushing to heroku if assets have changed
- `git push heroku-dev` is staging app remote
- `git push heroku-prod` is production app remote
- heroku only builds from master branch

## Known Issues

- bcrypt gem path set to get from github, as ruby gems version was not working when developing on Windows.
- tzinfo-data has platforms removed as this stops it working
