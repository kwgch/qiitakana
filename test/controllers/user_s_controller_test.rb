require 'test_helper'

class UserSControllerTest < ActionController::TestCase
  setup do
    @user_ = user_s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_" do
    assert_difference('User.count') do
      post :create, user_: { email: @user_.email, name: @user_.name }
    end

    assert_redirected_to user__path(assigns(:user_))
  end

  test "should show user_" do
    get :show, id: @user_
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_
    assert_response :success
  end

  test "should update user_" do
    patch :update, id: @user_, user_: { email: @user_.email, name: @user_.name }
    assert_redirected_to user__path(assigns(:user_))
  end

  test "should destroy user_" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user_
    end

    assert_redirected_to user_s_path
  end
end
