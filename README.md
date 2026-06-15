# Recipes — companion app for [Minitest Rails](https://minitestrails.com/)

This is the hands-on Rails app behind [**Minitest Rails**](https://minitestrails.com/), a free guide to testing Rails applications with Minitest — no second test stack, no guesswork.

You follow one app from a simple Recipe scaffold through model tests, fixtures, integration tests, system tests, and CI. Clone this repo when you want a working reference beside the guide, or build along chapter by chapter and compare your work here.

**[Start the guide →](https://minitestrails.com/)**

## Why this repo exists

Rails already ships Minitest. This app shows what a real, tested Rails 8 codebase looks like when you stick to defaults:

- **Minitest** for unit, integration, and system tests
- **Fixtures** for fast, predictable test data
- **Capybara + Selenium** for browser-level smoke tests
- **GitHub Actions** running the full suite on every push

The guide walks through each layer in plain language. This repo is the finished reference you can run, read, and diff against as you learn.

## What's in the app

A small CRUD app for managing recipes:

| Layer | What you'll find |
| --- | --- |
| **Model** | `Recipe` with validations |
| **Controller** | Full scaffolded `RecipesController` |
| **Views** | Standard Rails ERB templates |
| **Tests** | Model, integration, controller, and system tests under `test/` |
| **CI** | Linting, security scans, and test jobs in `.github/workflows/ci.yml` |

As the guide grows (mailers, jobs, auth, and more), this app grows with it.

## Requirements

- Ruby **4.0.2** (see `.ruby-version`)
- Bundler
- SQLite (included via the `sqlite3` gem)
- Chrome/Chromium for system tests (headless, via Selenium)

## Setup

```bash
git clone https://github.com/minitestrails/recipes.git
cd recipes
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
# Full test suite (models, integration, controllers)
bin/rails test

# System tests only (requires Chrome/Chromium)
bin/rails test:system

# Everything CI runs locally
bin/ci
```

Green output here is the goal every chapter builds toward.

## Test layout

```
test/
├── models/           # Unit tests — validations, business logic
├── integration/      # HTTP-level flows (list, create, show)
├── controllers/      # Scaffold-generated controller coverage
├── system/           # Browser tests with Capybara
└── fixtures/         # Shared test data (recipes.yml)
```

New to the distinction? Read [Kinds of Rails tests](https://minitestrails.com/guide/kinds-of-rails-tests/) on the guide.

## Follow along

| Step | Guide chapter |
| --- | --- |
| 1. Understand the approach | [Introduction](https://minitestrails.com/guide/introduction/) |
| 2. Set up this app | [Setting up Minitest](https://minitestrails.com/guide/setting-up-minitest/) |
| 3. Write your first test | [Your first test](https://minitestrails.com/guide/your-first-test/) |
| 4. Browse all 22 chapters | [Full guide index](https://minitestrails.com/guide/) |

## Tech stack

- Rails 8.1
- Minitest (Rails default)
- SQLite
- Hotwire (Turbo + Stimulus)
- Capybara + Selenium WebDriver
- GitHub Actions CI

## Contributing

Found a mismatch between a guide chapter and this repo? [Open an issue](https://github.com/minitestrails/recipes/issues) or send a PR.

## License

This companion app is open source. The [Minitest Rails guide](https://minitestrails.com/) is free to read — help keep it that way by sharing it with anyone learning Rails testing.

---

Built by [Prabin Poudel](https://minitestrails.com/) · [@coolprobn](https://github.com/coolprobn)
