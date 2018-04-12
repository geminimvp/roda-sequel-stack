# frozen_string_literal: true

require "rake/testtask"

Dir.glob("lib/tasks/*.rake").each { |r| load r }

Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end
desc "Run tests"

task default: :test
