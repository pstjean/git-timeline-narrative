# Installation

You will need the following system packages:
- Node JS (16.2.0+)
- Ruby (2.7.3+)
- Postgres (13.2+)
- Yarn (1.22.10+)
- CMake (3.15.2+)
- Graphviz (2.48.0+)

Once these are installed, clone this repository, switch to the directory you cloned, and run `bundle` and then `bin/yarn`

To create the project database, run `bin/rails db:create` from the project's root directory. You may have to update the values of the `DATABASE_USERNAME` and `DATABASE_PASSWORD` environment variables in order to reflect your local Postgres instance's configuration. Then, run `bin/rails db:migrate` and `bin/rails db:migrate RAILS_ENV=test`

# Serve

To run the development server, run `bin/rails s` from the project's root directory.

# Test

To run the tests, run `bin/rails spec` from the project's root directory.
