class ConnectionsController < ApplicationController

  def show
    @consultant_one = Consultant.find_by(employee_id: params[:first_employee_id])
    @consultant_two = Consultant.find_by(employee_id: params[:second_employee_id])
  end

  def index
  end
end
