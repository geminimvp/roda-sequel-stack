# frozen_string_literal: true

source "https://rubygems.org"
ruby "2.5.1"

gem "foreman"
gem "pg", "~> 1.0.0"
gem "puma"
gem "rack-unreloader"
gem "rake"
gem "roda", "~> 3.6.0"
gem "sequel"
gem "sequel_pg", require: "sequel"

group :test, :development do
  gem "dotenv"
  gem "pry"
  gem "pry-byebug"
  gem "rubocop"
end

group :test do
  gem "minitest"
  gem "rack-test"
end
