require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

run ApplicationController

use Rack::MethodOverride

use ZookeepersController
use AnimalsController
use ZoosController
use SessionsController