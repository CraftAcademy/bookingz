class Api::ApiController < ActionController::API

  def ping
    render json: {message: 'Pong'}
  end

  def index
    @date = set_date
    @resources = Resource.all
  end

  def show
    @date = set_date
    @resource = Resource.find_by(uuid: params[:uuid])
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.schedule = IceCube::Schedule.new(Date.today - 1.year, duration: 1.year)
    @resource.schedule.add_recurrence_rule IceCube::Rule.daily
    if @resource.save
      #render json: {message: 'success', resource: @resource}
      render :create
    else
      render json: {message: @resource.errors.full_messages}
    end
  end


  private

  def set_date
    params[:date] || Date.today.to_s
  end

  def resource_params
    params.require(:resource).permit(:uuid, :designation, :capacity)
  end
end
