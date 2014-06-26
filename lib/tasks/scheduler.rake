desc "Send connections email to Pam"
task :email_pam => :environment do
    puts "Finding Pam in Consultants..."
    pam = Consultant.where(full_name: "Pam Ocampo").first
    puts "Finding Pam's connections..."
    mentors_for_pam = ConnectionService.best_mentors_for pam
    mentees_for_pam = ConnectionService.best_mentees_for pam
    connections = {:mentors => mentors_for_pam, :mentees => mentees_for_pam}

    puts "Crafting connections email..."
    MatchMailer.send_connections(pam, connections).deliver
    puts "Email sent!"
end

