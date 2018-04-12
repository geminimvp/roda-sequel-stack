# frozen_string_literal: true

ENV["RACK_ENV"] = "test"

require_relative "../app"
require "minitest/autorun"
require "rack/test"

class AppServiceTest < Minitest::Test
  include Rack::Test::Methods

  def app
    AppService
  end

  def json_response
    JSON.parse(last_response.body)
  end
end
