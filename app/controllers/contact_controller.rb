class ContactController < ApplicationController

  def create
    if params[:github_account].blank?
      flash[:alert] = "I can't save a github account without a username!"
    else
      if Contact.find_by(github_account: params[:github_account])
        flash[:alert] = "That account is already registered to another employee"
      else
        @contact = Contact.create(employee_id: params[:employee_id], github_account: params[:github_account])
      end
    end

    respond_to do |format|
      format.html { redirect_to consultant_path(params[:employee_id], anchor: "panel-mentors") }
      format.js {}
    end

  end

end