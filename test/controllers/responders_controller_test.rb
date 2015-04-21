require "test_helper"

class RespondersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_response :success
  end

  def test_show
    get :show
    assert_response :success
  end

  def test_update
    get :update
    assert_response :success
  end

  def test_create
    get :create
    assert_response :success
  end

end
