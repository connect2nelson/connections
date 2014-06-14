class ConsultantsController < ApplicationController
  before_action :authenticate_user

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name

  def show
    @consultant = Consultant.find_by(employee_id: params[:id])
  end


end
