# frozen_string_literal: true

require "yaml"
require "erb"

if ENV["RACK_ENV"] == "development" && !defined?(Unreloader)
  require "rack/unreloader"
  Unreloader = Rack::Unreloader.new(reload: false)
end

template = ERB.new(File.read(File.join(__dir__, "config/database.yml")))
settings = YAML.load(template.result)[ENV.fetch("RACK_ENV", "development")]

# Sequel Configuration
Sequel::Model.cache_associations = ENV["RACK_ENV"] == "production"
Sequel.default_timezone = :utc

DB = Sequel.connect(settings)
DB.extension :pg_json

Sequel::Model.plugin :json_serializer

# require "lib/models/user"
# require "lib/models/event"
