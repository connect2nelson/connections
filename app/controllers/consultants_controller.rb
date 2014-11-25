class ConsultantsController < ApplicationController

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name, :full => true, :extra_data => [:employee_id]

  def show
    @consultant = Consultant.find_by(employee_id: params[:id])
    @peers = ConnectionService.best_peers_for(@consultant)
    @contact = ContactService.contacts_for(@consultant)

    @sponsees = SponsorshipService.get_sponsees_for(@consultant)
    @mentees = remove_sponsees_from(ConnectionService.best_mentees_for(@consultant))

    @sponsors = SponsorshipService.get_sponsors_for(@consultant)
    @mentors = remove_sponsors_from(ConnectionService.best_mentors_for(@consultant))

    @connected =  ENV["SECURITY_ENABLED"]
  end

  def remove_sponsees_from(mentees)
    @sponsees.each do |sponsee_connection|
      existing_sponsorship_index = mentees.index { |mentee_connection|
        mentee_connection.mentee.employee_id == sponsee_connection.mentee.employee_id && mentee_connection.mentor.employee_id == sponsee_connection.mentor.employee_id
      }
      mentees.delete_at(existing_sponsorship_index) unless existing_sponsorship_index.nil?
    end
    mentees
  end

  def remove_sponsors_from(mentors)
    @sponsors.each do |sponsor_connection|
      existing_sponsorship_index = mentors.index { |mentor_connection|
        mentor_connection.mentee.employee_id == sponsor_connection.mentee.employee_id && mentor_connection.mentor.employee_id == sponsor_connection.mentor.employee_id
      }
      mentors.delete_at(existing_sponsorship_index) unless existing_sponsorship_index.nil?
    end
    mentors
  end

  def index
    @offices = OfficeService.find_all_offices
    @search_results = Consultant.where(full_name: /#{params[:full_name]}/i) if params[:full_name]
  end

end
