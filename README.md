# Cookbook — companion app for [Minitest Rails](https://minitestrails.com/)

This is the hands-on Rails app behind [**Minitest Rails**](https://minitestrails.com/), a free guide to testing Rails applications with Minitest. No second test stack. No guesswork.

**Cookbook** is the example app you build through the guide. A recipe is one resource inside it. The app grows into nested associations, authentication, authorization, mailers, Turbo Frames and Streams, and CI. Clone this repo for a working reference beside the guide, or build chapter by chapter and compare your work here.

**[Start the guide →](https://minitestrails.com/)**

## Why this repo exists

Rails already ships Minitest. This app shows what a real, tested Rails 8 codebase looks like when you stick to defaults:

- **Minitest** for model, integration, mailer, and system tests
- **Fixtures** for fast, predictable test data
- **Capybara + Selenium** for browser-level checks
- **Action Policy** for authorization
- **GitHub Actions** running the full suite on every push

The guide walks through each layer in plain language. This repo is the finished reference you can run, read, and diff against as you learn.

## What's in the app

Cookbook starts as simple recipe CRUD and grows with the guide:

| Layer | What you'll find |
| --- | --- |
| **Models** | `Recipe`, nested `Ingredient` and `Step`, validations, and scopes |
| **Auth** | Rails 8 authentication, sessions, and password reset |
| **Authorization** | Action Policy ownership rules for recipes, ingredients, and steps |
| **Mailers** | Recipe share mail and password reset mail, with previews and tests |
| **Views** | ERB plus Hotwire (Turbo Frames, Turbo Streams, nested forms) |
| **Tests** | Model, integration, mailer, and system tests under `test/` |
| **CI** | Lint, security scans, and test jobs in `.github/workflows/ci.yml` |

Later guide chapters (jobs, external HTTP mocks, coverage habits) keep using this same app as the through-line.

## Requirements

- Ruby **4.0.2** (see `.ruby-version`)
- Bundler
- SQLite (via the `sqlite3` gem)
- Chrome or Chromium for system tests (headless Selenium)
- libvips (Active Storage variants via `ruby-vips`; CI installs this on test jobs)

## Setup

```bash
git clone https://github.com/minitestrails/cookbook.git
cd cookbook
bin/setup --skip-server
```

`bin/setup` installs gems, prepares the database, and clears logs. Omit `--skip-server` to boot the dev server when setup finishes.

Start the app manually:

```bash
bin/dev
```

Visit [http://localhost:3000/recipes](http://localhost:3000/recipes).

## Running tests

```bash
# Full non-system suite (models, integration, mailers, controllers)
bin/rails test

# System tests only (needs Chrome or Chromium)
bin/rails test:system

# Same checks CI runs locally
bin/ci
```

Green output here is the goal every chapter builds toward.

## Test layout

```
test/
├── models/           # Validations, scopes, model behavior
├── integration/      # HTTP flows (CRUD, auth, authorization)
├── mailers/          # Delivery and body assertions (+ previews/)
├── controllers/      # Scaffold and session/password coverage
├── system/           # Browser tests with Capybara
└── fixtures/         # Shared YAML data (users, recipes, …)
```

New to the distinction? Read [Kinds of Rails tests](https://minitestrails.com/guide/kinds-of-rails-tests/) on the guide.

## Follow along

| Step | Guide chapter |
| --- | --- |
| 1. Understand the approach | [Introduction](https://minitestrails.com/guide/introduction/) |
| 2. Set up this app | [Setting up Minitest](https://minitestrails.com/guide/setting-up-minitest/) |
| 3. Write your first test | [Your first test](https://minitestrails.com/guide/your-first-test/) |
| 4. Auth and password reset | [Testing authentication](https://minitestrails.com/guide/testing-authentication/) |
| 5. Ownership rules | [Authorization testing](https://minitestrails.com/guide/authorization-testing/) |
| 6. Mailers | [Testing mailers](https://minitestrails.com/guide/testing-mailers/) |
| 7. Turbo Frames and Streams | [Testing Turbo Frames and Streams](https://minitestrails.com/guide/testing-turbo-frames-and-streams/) |
| 8. Browse all chapters | [Full guide index](https://minitestrails.com/guide/) |

## Tech stack

- Rails 8.1
- Minitest (Rails default)
- SQLite
- Hotwire (Turbo + Stimulus)
- Action Policy
- Capybara + Selenium WebDriver
- GitHub Actions CI

## Contributing

Found a mismatch between a guide chapter and this repo? [Open an issue](https://github.com/minitestrails/cookbook/issues) or send a PR.

## License

This companion app is open source. The [Minitest Rails guide](https://minitestrails.com/) is free to read. Share it with anyone learning Rails testing.

---

Built by [Prabin Poudel](https://minitestrails.com/) · [@coolprobn](https://github.com/coolprobn)
