desc "Send connections email to Pam"
task :email_pam => :environment do
    puts "Finding Pam in Consultants..."
    pam = Consultant.where(full_name: "Pam Ocampo").first
    puts "Finding Pam's connections..."
    connections = ConnectionService.best_match_for pam
    puts "Crafting connections email..."
    MatchMailer.send_connections(pam, connections).deliver
    puts "Email sent!"
end

