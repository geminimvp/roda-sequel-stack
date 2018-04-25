# frozen_string_literal: true

require "./db"

unless defined?(Unreloader)
  require "rack/unreloader"
  Unreloader = Rack::Unreloader.new(reload: false)
end

Unreloader.require("lib/models") { |f| Sequel::Model.send(:camelize, File.basename(f).sub(/\.rb\z/, "")) }
