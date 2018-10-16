provider "heroku" {
  email = "${var.heroku_email}"
  api_key = "${var.heroku_api_key}"
}

resource "heroku_app" "spree" {
  name = "${terraform.workspace}-spree"
  region = "eu"

  buildpacks = [
    "heroku/ruby",
    "heroku/nodejs"
  ]

  config_vars = {
    RAILS_ENV = "production"
  }
}

resource "heroku_addon" "database" {
  app = "${heroku_app.spree.name}"
  plan = "heroku-postgresql:hobby-dev"
}
