class ConsultantsController < ApplicationController
  before_action :authenticate_user

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name, :full => true, :extra_data => [:employee_id]

  def show
    @consultant = Consultant.find_by(employee_id: params[:id])
    @mentors = ConnectionService.best_mentors_for(@consultant)
    @mentees = ConnectionService.best_mentees_for(@consultant)
    @activities = ActivityService.github_events(params[:id])
    @connected =  ENV["SECURITY_ENABLED"]
  end

  def index
    @search_results = Consultant.where(full_name: /#{params[:full_name]}/i) if params[:full_name]
  end

end
