class EmergenciesController < ApplicationController
  def index
    @emergencies = Emergency.all
  end

  def show
    @emergency = Emergency.find_by(code: params[:code])
    render json: { message: 'page not found' }, status: 404 if @emergency.nil?
  end

  def create
    @emergency = Emergency.new(emergency_create_params)
    if @emergency.save
      Emergency.dispatch_responders(@emergency)
      render 'show'
    else
      # TODO: create shared error page for emergencies and responders
      # TODO: create error for unpermitted params
      render 'errors', status: 422
    end
  end

  def update
    @emergency = Emergency.find_by(code: params[:code])
    if @emergency.update_attributes(emergency_update_params)
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

  def emergency_create_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def emergency_update_params
    params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity)
  end
end
