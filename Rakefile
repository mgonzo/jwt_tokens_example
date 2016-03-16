# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :test do
  desc "Test test/services/* code"
  Rails::TestTask.new(services: 'test:prepare') do |t|
    t.pattern = 'test/services/**/*_test.rb'
  end
end

Rake::Task['test:run'].enhance ["test:services"]
