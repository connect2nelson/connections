namespace :email_updates do
  desc 'Email updates to consultants in San Francsico'
  task :sf_updates => :environment do
    ConnectionService.sf_office.select(&:match?).each do |connection|
      puts "#{connection.mentee.full_name} has a potential mentor of #{connection.mentor.full_name}"
    end
  end
end
