class ContactController < ApplicationController

  def create
    if params[:github_account].blank?
      flash[:alert] = "I can't save a github account without a username!"
    else
      @contact = Contact.create(employee_id: params[:employee_id], github_account: params[:github_account])
    end

    respond_to do |format|
      format.html { redirect_to consultant_path(params[:employee_id], anchor: "panel-mentors") }
      format.js {}
    end

  end

end