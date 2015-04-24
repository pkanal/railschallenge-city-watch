class RespondersController < ActionController::Base
  # TODO: Change all error codes to appropriate symbols
  def index
    @responders = Responder.all
    if params[:show] == 'capacity'
      @capacity = Responder.show_city_capacity
      render json: { capacity: @capacity }, status: :ok
    else
      @responders = Responder.all
    end
  end

  def show
    @responder = Responder.find_by(name: params[:name])
    render json: { message: 'page not found' }, status: 404 if @responder.nil?
  end

  def create
    @responder = Responder.new(responder_create_params)
    if @responder.save
      render 'show'
    else
      # TODO: create shared error page for emergencies and responders
      render 'errors', status: 422
    end
  end

  def update
    @responder = Responder.find_by(name: params[:name])
    if @responder.update_attributes(responder_update_params)
      render 'show'
    else
      render 'errors', status: 422
    end
  end

  def edit
    render json: { message: 'page not found' }, status: 404
  end

  def new
    render json: { message: 'page not found' }, status: 404
  end

  def destroy
    render json: { message: 'page not found' }, status: 404
  end

  private

  def responder_create_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

  def responder_update_params
    params.permit(:on_duty)
  end
end
