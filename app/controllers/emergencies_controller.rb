class EmergenciesController < ActionController::Base
  def index
    @emergencies = Emergency.all
  end

  def show
    @emergency = Emergency.find_by(code: params[:code])
    render json: { message: 'page not found' }, status: 404 if @emergency.nil?
  end

  def create
    @emergency = Emergency.new(emergency_params)
    if @emergency.save
      render 'show'
    else
      # TODO: create shared error page for emergencies and responders
      render 'errors'
    end
  end

  def update
    @emergency = Emergency.find_by(code: params[:code])
    if @emergency.update_attributes(permitted_params)
      render 'show'
    else
      render 'errors'
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

  def permitted_params
    params.permit(:fire_severity, :police_severity, :medical_severity)
  end
end
