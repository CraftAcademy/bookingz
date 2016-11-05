class FacilitiesController < ApplicationController
  before_action :authenticate_superuser

  def index
    @facilities = Facility.all
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      flash[:notice] = "Facility #{@facility.name} was saved"
      redirect_to facilities_path
    else
      render :new
    end
  end

  def assign_user
    user = User.find(params[:user])
    facility = Facility.find(params[:facility_id])
    user.facility = facility
    user.save

    redirect_back(fallback_location: root_path)
  end

  private

  def facility_params
    params.require(:facility).permit(:name)
  end
end
