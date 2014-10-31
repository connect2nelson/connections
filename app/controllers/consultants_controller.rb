class ConsultantsController < ApplicationController

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name, :full => true, :extra_data => [:employee_id]

  def show
    @consultant = Consultant.find_by(employee_id: params[:id])
    @mentors = ConnectionService.best_mentors_for(@consultant)
    @mentees = ConnectionService.best_mentees_for(@consultant)
    @peers = ConnectionService.best_peers_for(@consultant)
    @sponsees = SponsorshipService.get_sponsees_for(@consultant)
    @contact = ContactService.contacts_for(@consultant)
    @connected =  ENV["SECURITY_ENABLED"]
  end

  def index
    @offices = OfficeService.find_all_offices
    @search_results = Consultant.where(full_name: /#{params[:full_name]}/i) if params[:full_name]
  end

end
