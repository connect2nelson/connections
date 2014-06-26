desc "Send connections email to Pam"
task :email_pam => :environment do
    puts "Finding Pam in Consultants..."
    pam = Consultant.where(full_name: "Derek Hammer").first
    puts "Finding Pam's connections..."
    mentors_for_pam = ConnectionService.best_mentors_for pam
    mentees_for_pam = ConnectionService.best_mentees_for pam
    connections = {:mentors => mentors_for_pam, :mentees => mentees_for_pam}

    puts "Crafting connections email..."
    MatchMailer.send_connections(pam, connections).deliver
    puts "Email sent!"
end
desc "Send connections email to San Francisco"
task :email_sf => :environment do
    puts "Getting all the consultants in San Francisco"
    sf_thoughtworkers = ConnectionService.for_office('San Francisco')
    sf_thoughtworkers.each do |thoughtworker|
        puts 'Finding matches for #{thoughtworker.full_name}'
        mentors = ConnectionService.best_mentors_for thoughtworker
        mentees = ConnectionService.best_mentees_for thoughtworker
        connections = {:mentors => mentors, :mentees => mentees}
        MatchMailer.send_connections(thoughtworker, connections).deliver
    end
end

