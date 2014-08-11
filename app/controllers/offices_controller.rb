class OfficesController < ApplicationController

  def show
    titleized_name = params[:name].titleize
    @office = OfficeService.find_by_name(titleized_name)
  end
end
