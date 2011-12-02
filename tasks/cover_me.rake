require 'cover_me'

namespace :cover_me do
  desc "Generate coverage report after running specs"
  task :report do
    puts "Reporting!"
    CoverMe.config.formatter = CoverMe::EmmaFormatter
    CoverMe.config.at_exit = Proc.new {}
    CoverMe.complete!
  end
end
