namespace :email_updates do
  desc 'Email updates to consultants in San Francsico'
  task :sf_updates => :environment do
    ConnectionService.sf_office.select(&:match?).each do |connection|
      puts "#{connection.mentee.full_name} has a potential mentor of #{connection.mentor.full_name}"
    end
  end

  desc 'Email list of connections to pam'
  task :pam => :environment do
      pam = Consultant.where(full_name: "Pam Ocampo").first
      connections = ConnectionService.best_match_for pam
      MatchMailer.send_connections(pam, connections).deliver
  end
end
