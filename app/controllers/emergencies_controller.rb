class EmergenciesController < ActionController::Base
  def index
    @emergencies = Emergency.all
  end

  def show
    @emergency = Emergency.find_by(code: params[:code])
  end

  def create
    @emergency = Emergency.new(emergency_params)
    if @emergency.save
      render 'show'
    else
      render status: 422, json: { message: @emergency.errors }
    end
  end

  def new
    render json: { message: 'page not found' }, status: 404
  end

  def edit
    render json: { message: 'page not found' }, status: 404
  end

  def delete
    render json: { message: 'page not found' }, status: 404
  end


  private

  def emergency_params
    params.permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end
