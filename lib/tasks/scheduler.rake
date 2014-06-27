namespace :github do

    desc "Fetch github data for employees"
    task :update => :environment do
      puts "Finding consultants with github account..."
      thoughtworkers = ContactService.all_with_github
      puts "Updating github events for each consultant..."
      ActivityService.update_github(thoughtworkers)
      puts "Updated!"
    end
end

namespace :email do
    desc "Send connections email to Pam"
    task :pam => :environment do
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

    task :mail_one_consultant, [:first_name, :last_name] => :environment do |t, args|
        puts "Finding name in Consultants..."
        puts "Finding the argument passed in: #{args}"
        full_name = "#{args[:first_name]} #{args[:last_name]}"
        consultant = Consultant.where(full_name: full_name).first
        puts "Finding their connections..."
        mentors_for_consultant = ConnectionService.best_mentors_for consultant
        mentees_for_consultant = ConnectionService.best_mentees_for consultant
        connections = {:mentors => mentors_for_consultant, :mentees => mentees_for_consultant}
        puts "Crafting connections email..."
        MatchMailer.send_connections(consultant, connections).deliver
        puts "Email sent!"
    end

    desc "Send connections email to San Francisco"
    task :sf => :environment do
        puts "Getting all the consultants in San Francisco"
        sf_thoughtworkers = ConnectionService.for_office('San Francisco')
        sf_thoughtworkers.each do |thoughtworker|
            puts "Finding matches for #{thoughtworker.full_name}"
            mentors = ConnectionService.best_mentors_for thoughtworker
            mentees = ConnectionService.best_mentees_for thoughtworker
            connections = {:mentors => mentors, :mentees => mentees}
            MatchMailer.send_connections(thoughtworker, connections).deliver
        end
    end

end
