require 'test_helper'

class OrderMembersControllerTest < ActionController::TestCase
  setup do
    @order_member = order_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_member" do
    assert_difference('OrderMember.count') do
      post :create, order_member: { order_id: @order_member.order_id, status_user: @order_member.status_user, user_id: @order_member.user_id }
    end

    assert_redirected_to order_member_path(assigns(:order_member))
  end

  test "should show order_member" do
    get :show, id: @order_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_member
    assert_response :success
  end

  test "should update order_member" do
    patch :update, id: @order_member, order_member: { order_id: @order_member.order_id, status_user: @order_member.status_user, user_id: @order_member.user_id }
    assert_redirected_to order_member_path(assigns(:order_member))
  end

  test "should destroy order_member" do
    assert_difference('OrderMember.count', -1) do
      delete :destroy, id: @order_member
    end

    assert_redirected_to order_members_path
  end
end
