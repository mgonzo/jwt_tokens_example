require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @token_service = Tokens.new()
    @uuid = 'fbf5006a-f7b7-487a-a911-dea23fa4b38a'
    @token = @token_service.generate_token(@uuid, 1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: @user.name, password: @user.password, token: @user.token, uuid: @user.uuid }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    @request.headers["HTTP_AUTHORIZATION"] = @token
    get :show, id: @user 
    assert_response :success
  end

  test "should get edit" do
    @request.headers["HTTP_AUTHORIZATION"] = @token
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    @request.headers["HTTP_AUTHORIZATION"] = @token
    patch :update, id: @user, user: { name: @user.name, password: @user.password, token: @user.token, uuid: @user.uuid }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    @request.headers["HTTP_AUTHORIZATION"] = @token
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
