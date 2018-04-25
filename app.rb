# frozen_string_literal: true

require "bundler"
Bundler.require
require "./models"

# AppService roda application for microservice
class AppService < Roda
  plugin :default_headers, "Content-Type" => "application/json; charset=utf-8"
  plugin :halt
  plugin :all_verbs

  route do |r|
    r.root do
      r.get do
        { hello: "Hello AppService template" }.to_json
      end
    end
  end
end
