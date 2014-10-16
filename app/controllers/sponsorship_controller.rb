class SponsorshipController < ApplicationController

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name, :full => true, :extra_data => [:employee_id]

  def create
    if params[:sponsor_id].nil? || params[:sponsee_id].nil?
      flash[:alert] = "I can't save a sponsee without an employee id!"
    else
      Sponsorship.create(sponsor_id: params[:sponsor_id], sponsee_id: params[:sponsee_id])
    end

    redirect_to '/consultants/'+ params[:sponsor_id]
  end

  private
  def sponsorship_params
    params.require(:sponsor_id, :sponsee_id)
  end


end
