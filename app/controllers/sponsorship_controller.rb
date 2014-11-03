class SponsorshipController < ApplicationController

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name, :full => true, :extra_data => [:employee_id]

  def create
    if params[:sponsor_full_name].blank?
      flash[:alert] = "I can't save a sponsor without a name!"
    else
      if sponsor = Consultant.find_by(full_name: params[:sponsor_full_name])
        params_sponsor_id = sponsor.employee_id
        @connection = create_sponsorship(params_sponsor_id)
      else
        flash[:alert] = "That is not a valid sponsor!"
      end
    end

      respond_to do |format|
        format.html { redirect_to consultant_path(params[:sponsor_id], anchor: "panel-mentors") }
        format.js {}
      end

  end

  def create_sponsee
    @connection = create_sponsorship(params[:sponsor_id])

    respond_to do |format|
      format.html { redirect_to consultant_path(params[:sponsor_id], anchor: "panel-mentees") }
      format.js {}
    end

  end

  def create_sponsorship(sponsor_id)
    sponsorship = Sponsorship.create(sponsor_id: sponsor_id, sponsee_id: params[:sponsee_id])
    SponsorshipService.get_connection_for(sponsorship)
  end

  def delete
    sponsorRelationship = Sponsorship.where(sponsorship_params).first
    @deleted_sponsee_id = sponsorship_params[:sponsee_id]
    if sponsorRelationship.delete
      respond_to do |format|
        format.html { redirect_to consultant_path(params[:sponsor_id], anchor: "panel-mentees") }
        format.js {}
      end
    else
      flash[:alert] = "Issue found trying to delete record."
    end

  end

  def sponsorless
    @sponsorless = SponsorshipService.get_sponsorless_individuals_for(params[:office])
    @coachless = SponsorshipService.get_sponsorless_ACs_for(params[:office])
    @office_name = params[:office]
  end



  private
  def sponsorship_params
    params.permit(:sponsor_id, :sponsee_id)
  end

end
