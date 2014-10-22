class OfficesController < ApplicationController

  def show
    titleized_name = params[:name].titleize
    @office = OfficeService.find_by_name(titleized_name)
  end

  def network
    data = File.read(Rails.root+"app/assets/javascripts/network_data.json")
    # binding.pry
    respond_to do |format|
      format.html {}
      format.json { render :json => data.to_json }
    end
  end

end
