class OfficesController < ApplicationController

  def show
    titleized_name = params[:name].titleize
    @office = OfficeService.find_by_name(titleized_name)
  end

  def network
    titleized_name = params[:name].titleize
    @office = OfficeService.find_by_name(titleized_name)
    data = @office.sponsorship_network.to_json
    respond_to do |format|
      format.html {}
      format.json { render :json => data }
    end
  end

end
