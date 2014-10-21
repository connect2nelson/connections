class SponsorshipController < ApplicationController

  include Rails3JQueryAutocomplete::Orm::Mongoid
  autocomplete :consultant, :full_name, :full => true, :extra_data => [:employee_id]

    def create

      if params[:sponsor_id].nil? || params[:sponsee_id].nil?
        flash[:alert] = "I can't save a sponsee without an employee id!"
      else
        sponsorship = Sponsorship.create(sponsor_id: params[:sponsor_id], sponsee_id: params[:sponsee_id])
        @connection = SponsorshipService.get_connection_for(sponsorship)

        respond_to do |format|
          format.html { redirect_to consultant_path(params[:sponsor_id], anchor: "panel-sponsorship") }
          format.js {}
        end
      end
    end



  private
  def sponsorship_params
    params.require(:sponsor_id, :sponsee_id)
  end

end
