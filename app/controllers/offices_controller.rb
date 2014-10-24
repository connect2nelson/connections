class OfficesController < ApplicationController
  before_action :show, only: [:network]

  def show
    titleized_name = params[:name].titleize
    @office = OfficeService.find_by_name(titleized_name)
  end

  def network
    data = @office.sponsorship_network.to_json
    respond_to do |format|
      format.json { render :json => data }
    end
  end

end
