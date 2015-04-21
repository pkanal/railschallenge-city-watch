class RespondersController < ActionController::Base
  def index
    @responders = Responder.all
    if params[:show] == 'capacity'
      # TODO: Move to Responder model
      @capacity = {Fire: [], Police: [], Medical: []}
      @responders.each do |responder|
        @capacity[:Fire] << responder.capacity if responder.type == 'Fire'
        @capacity[:Police] << responder.capacity if responder.type == 'Police'
        @capacity[:Medical] << responder.capacity if responder.type == 'Medical'
      end
      render json: { capacity: @capacity }
    end
  end

  def show
    @responder = Responder.find_by(name: params[:name])
    render json: { message: 'page not found' }, status: 404 if @responder.nil?
  end

  def create
    @responder = Responder.new(responder_params)
    if @responder.save
      render 'show'
    else
      # TODO: create shared error page for emergencies and responders
      render 'errors', status: 422
    end
  end

  def update
    @responder = Responder.find_by(name: params[:name])
    if @responder.update_attributes(params.permit(:on_duty))
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

  def responder_params
    params.permit(:type, :name, :capacity)
  end
end
