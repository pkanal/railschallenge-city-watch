class RespondersController < ActionController::Base
  def index
    @responders = Responder.all
  end

  def show
  end

  def create
  end

  def update
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
end
