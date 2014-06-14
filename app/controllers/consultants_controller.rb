class ConsultantsController < ApplicationController
  before_action :authenticate_user

  def show
    @consultant = Consultant.find_by(employee_id: params[:id])
  end



end
