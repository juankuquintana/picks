# Picks

An application for pools and sports betting

## Installation

You can setup the application with:

```bash
$ bin/setup
```

Afterwards, you should be able to set the necessary ENV vars in your .env file.

## Starting the application

1. Run the application with the following command.

```bash
$ overmind start
```

2. Now you can visit [`localhost:3000`](http://localhost:3000) from your browser.

3. You can access the console via.

```bash
$ rails c
```

## Testing the application

Run the test suite with the following command:

```bash
$ rails db:setup RAILS_ENV=test
$ rails test
```

To run the JS test suite use the following command:

```bash
$ npm install
$ npm test
```

## Our database

You can run the database seeds with the following command:

```bash
$ rails db:seed
```

## Local development data

You can set your application with initial data with the following commands:

```bash
$ rails c
```

```ruby
Sports::SyncLeagueService.call(Sports::Adapters::ApiSportsAdapter::KEY, ApiSports::Extensions::LigaMx::ID)
league = League.last
Sports::SyncTeamsService.call(Sports::Adapters::ApiSportsAdapter::KEY, league, 2024)
Sports::SyncRoundsService.call(Sports::Adapters::ApiSportsAdapter::KEY, league, 2024)
Sports::SyncLeagueFixturesService.call(Sports::Adapters::ApiSportsAdapter::KEY, league, 2024)
```

## Architecture

### Feature flags

Sometimes we may want to test something before releasing, for that we use feature flags using [flipper](https://www.flippercloud.io/docs) as a gem for it. Accessing Flipper directly should be avoided so it is encapsulated within `/app/queries/feature_flag_query`. You can access the feature flags visiting [`localhost:3000/admin/flipper`](http://localhost:3000/admin/flipper) from your browser.

### Interactors

To keep controllers thin and our code better organized we use interactors, they provides a common interface for accessing our business logic and should only be used when theres a user action. They are found under `/app/interactors` and you can learn more about them [here](https://github.com/sunny/actor). Remember to use `.result()` instead of `.call()`if you want to use `result.success?`.

### Processors



### Issues and triaging

Our issues are reported automatically to [Sentry](https://sentry.io/).

### Jobs

To run async and cron jobs we use [Sidekiq](https://github.com/sidekiq/sidekiq) + [Sidekiq Cron](https://github.com/sidekiq-cron/sidekiq-cron). You can access the sidekiq UI visiting [`localhost:3000/admin/sidekiq`](http://localhost:3000/admin/sidekiq) from your browser.

### Logs and observability

We use [NewRelic](https://newrelic.com/) to keep observability of our system, use `Picks::Logger.log` to log within the application.

### Services

Our business logic is hold inside services, services should encapsulate a single purpose, they are found under `/app/services`. You can learn more about how we use them [here](https://github.com/Selleo/pattern?tab=readme-ov-file#service).

### System configuration

Under `/config/settings` you will find our system variables, you can override variables by creating a `/config/settings/local.rb` file.

## Coding guidelines

To keep our code clean we use linters and code formatters, see below:

[Rubocop](https://github.com/rubocop/rubocop) can be run with the following command:

```bash
$ rubocop
```

[erblint](https://github.com/Shopify/erb-lint) keeps our html source well formatted, you can run it with the following command:

```bash
$ bundle exec erblint --lint-all -a
```

And, we use [overcommit](https://github.com/sds/overcommit/) to run our linters, code formatters and tests before commiting, you can disable it by prepending the following command:

```bash
$ OVERCOMMIT_DISABLE=1
```

## Deploy

We use [Heroku](https://www.heroku.com/), run the following commands to setup our server:

```bash
$ heroku run rails db:migrate --app picks
$ heroku labs:enable runtime-dyno-metadata --app picks
```

## Functionality

### Admin site
- Our admin site can be found in `/admin`, only users with the `admin_at` attribute set will be able to access.

### Accounts, memberships and users
- A user holds the authentication information for accessing the application, they can be related to multiple accounts.
- A membership is the relationship between these models.

### Activity logs
- Our activity logs hold valuable information related to users and accounts. Think of it as an audit log.

## Roadmap
- Permitir hacer una apuesta
  - Guardar el status de un fixture
- Listar Quinielas y permitir crearlas
