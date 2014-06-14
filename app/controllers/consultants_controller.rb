class ConsultantsController < ApplicationController

  def show
    @consultant = Consultant.find(employee_id: params[:id])
  end

end
