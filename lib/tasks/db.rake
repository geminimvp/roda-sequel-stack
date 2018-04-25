# frozen_string_literal: false

namespace :db do
  desc "Creates the database for the current environment"
  task :create do
    `createdb #{pg_options}`
  end

  desc "Drops the database for the current environment"
  task :drop do
    `dropdb #{pg_options}`
  end

  desc "Run all migrations in migrate"
  task :migrate do
    require_relative "../../db"
    Sequel.extension(:migration)
    Sequel::Migrator.apply(DB, "migrate")
  end

  desc "Dumps the database schema into 'structure.sql'"
  task :dump do
    `pg_dump --schema-only #{pg_options} --file structure.sql`
  end

  desc "Loads the database schema from 'structure.sql'"
  task load: %i[drop create] do
    `psql #{pg_options} --file structure.sql`
  end

  desc "Create database structure from migrations"
  task bootstrap: %i[create migrate]

  desc "Reset database structure from migrations"
  task reset: %i[drop bootstrap]

  private

  def pg_options
    out = "#{settings["database"]} --host #{settings["host"]} --port #{settings["port"]}"
    out << "--username #{settings["username"]}" if settings["username"]
    out
  end

  def settings
    require "yaml"
    require "erb"

    template = ERB.new(File.read(File.join(__dir__, "../../config/database.yml")))
    YAML.load(template.result)[ENV.fetch("RACK_ENV", "development")]
  end
end
