class ConsultantsController < ApplicationController
  before_action :authenticate_user

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name, :full => true, :extra_data => [:employee_id]

  def show
    @consultant = Consultant.find_by(employee_id: params[:id])
    @connections = ConnectionService.best_match_for(@consultant)
  end
end
