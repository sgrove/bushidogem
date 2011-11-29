namespace :bushido do
  desc "Show the existing Mailroutes"
  task :mail_routes => :environment do
    Bushido::Mailroute.pretty_print_routes
  end
end
