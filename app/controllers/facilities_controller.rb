class FacilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_superuser, except: :show

  def index
    @facilities = Facility.all
  end

  def show
    @facility = Facility.find(params[:id])
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      message = t('dashboard.facility_create_successs', facility_name: @facility.name)
      flash[:notice] = message
      redirect_to facilities_path
    else
      render :new
    end
  end

  def assign_user
    user = User.find(params[:user])
    facility = Facility.find(params[:facility_id])
    user.update_attribute(:facility, facility)
    flash.now[:notice] = 'Thank you for contacting us! We\'ll be in touch shortly'
    redirect_back(fallback_location: root_path)
  end

  private

  def facility_params
    params.require(:facility).permit(:name, :code)
  end
end
