# README

## Getting Started

- You need Postgres running, eg. with https://postgresapp.com/
- `cp .env.example .env` # Copy the example environment file and add your secrets.
- `rbenv install 3.3.0` # Install Ruby with rbenv
- `bundle install` # Install the gems.
- `brew install redis` # Install Redis for the background job queue.
- `redis-server` # Run Redis to store the job queue.

- `bin/rails db:create` # Create the database.
- `bin/rails app:ai_engine:install:migrations` # Copy across the Engine migrations.
- `bin/rails db:migrate` # Migrate the database.
- `bin/dev` # Run the server.
- `standardrb --fix` # Run linter & auto-fix where possible.

## Set up AI::Engine

You need to purchase AI::Engine access to use this starter kit.
The AI_ENGINE_TOKEN must be set in the host environment (eg. with export AI_ENGINE_TOKEN=<key>), adding it to .env will not work.
The token should start with "activ-..."

You can add AI::Engine to your Gemfile like this - note the version (0.1.2 in this case) is set in the URL.

```
# The easiest way to get AI into your Rails app.
source "https://#{ENV["AI_ENGINE_TOKEN"]}@get.keygen.sh/97ac1497-64bd-4754-8336-d709b6df18b1/0.1.4" do
  gem "ai-engine", "~> 0.1.4"
end
```

You then need to add the migrations for the gem:

```
bundle exec rails ai_engine:install:migrations
```

And run them:

```
bundle exec rails db:migrate
```

## Set up Google Sign In with Omniauth

- Go to the [Google Cloud Console](https://console.cloud.google.com/)
- Click the dropdown at the top of the page and select "NEW PROJECT". Enter a project name and click "CREATE".
- Once it's created, click "SELECT PROJECT"
- At the top, search for "OAuth" and click "OAuth consent screen"
- Choose External and click CREATE.
- Fill in the form with your app's name, user support email, and developer contact information. You can leave the rest blank for now.
- Click SAVE AND CONTINUE.
- Click Credentials in the left sidebar and click CREATE CREDENTIALS.
- Choose OAuth client ID.
- For Application Type, choose Web application.
- Set the Name to your app's name.
- Under Authorized redirect URIs, add the following URI: http://localhost:3000/users/auth/google_oauth2/callback
- If you're deploying to production, you'll also need to add your app's domain as another URI with the same format: http://yourwebsite.com/users/auth/google_oauth2/callback
- Click CREATE.
- Set the Google Client ID and Secret in your .env file:

```
GOOGLE_OAUTH_CLIENT_ID=Your client id
GOOGLE_OAUTH_CLIENT_SECRET=Your client secret
```

## Tests

Run the tests with `rspec`.

## Debugging

Add a breakpoint with `debugger`. To debug the server, you need to remove `web: bin/rails server` from `Procfile.dev`, and then run `bin/dev` in one terminal tab and `bin/rails s` in another one, then you can use `debugger` breakpoints in the `bin/rails s` tab.

### VCR

AI Engine Starter Kit uses VCR to record HTTP requests and responses. To run a test against a live API and re-record a cassette:

```
VCR=all rspec spec/requests/storytellers_spec.rb:13
```

## To add libraries using ImportMaps

- Like this: `./bin/importmap pin alpinejs`

## Admin

- `http://localhost:3000/sidekiq` # Monitor queued jobs.

## Why .env rather than credentials?

- Makes it easier to manage for others using the template.
- I generally prefer to keep credentials out of the codebase, even encrypted.
