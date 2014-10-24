class SponsorshipController < ApplicationController

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name, :full => true, :extra_data => [:employee_id]

  def create
    if params[:sponsee_full_name].blank?
      flash[:alert] = "I can't save a sponsee without a name!"
    else
      if sponsee = Consultant.find_by(full_name: params[:sponsee_full_name])
        params_sponsee_id = sponsee.employee_id
        sponsorship = Sponsorship.create(sponsor_id: params[:sponsor_id], sponsee_id: params_sponsee_id)
        @connection = SponsorshipService.get_connection_for(sponsorship)
      else
        flash[:alert] = "That is not a valid sponsee!"
      end

    end

      respond_to do |format|
        format.html { redirect_to consultant_path(params[:sponsor_id], anchor: "panel-sponsorship") }
        format.js {}
      end

  end

  def delete
    sponsorRelationship = Sponsorship.where(sponsorship_params).first
    @deleted_sponsee_id = sponsorship_params[:sponsee_id]
    if sponsorRelationship.delete
      respond_to do |format|
        format.html { redirect_to consultant_path(params[:sponsor_id], anchor: "panel-sponsorship") }
        format.js {}
      end
    else
      flash[:alert] = "Issue found trying to delete record."
    end

  end



  private
  def sponsorship_params
    params.permit(:sponsor_id, :sponsee_id)
  end

end
