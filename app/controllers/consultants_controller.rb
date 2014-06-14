class ConsultantsController < ApplicationController

  def show
    @consultant = Consultant.find_by(employee_id: params[:id])
  end

end
