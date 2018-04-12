# frozen_string_literal: true

require "bundler"
Bundler.require
require "yaml"
require "erb"

template = ERB.new(File.read(File.join(__dir__, "config/database.yml")))
settings = YAML.load(template.result)[ENV.fetch("RACK_ENV", "development")]

# Sequel Configuration
Sequel::Model.cache_associations = ENV["RACK_ENV"] == "production"
Sequel.default_timezone = :utc

DB = Sequel.connect(settings)
DB.extension :pg_json
DB.extension :pg_enum

Sequel::Model.plugin :json_serializer

unless defined?(Unreloader)
  require 'rack/unreloader'
  Unreloader = Rack::Unreloader.new(reload: false)
end

Unreloader.require('lib/models'){|f| Sequel::Model.send(:camelize, File.basename(f).sub(/\.rb\z/, ''))}
