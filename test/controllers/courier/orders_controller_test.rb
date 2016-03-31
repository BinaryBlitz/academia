require 'test_helper'

class Courier::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @courier = couriers(:courier)
    @assigned_order = orders(:order)
    @new_order = orders(:new_order)
  end

  test 'should list orders' do
    get courier_orders_path, api_token: @courier.api_token
    assert_response :success
  end

  test 'should list assigned orders' do
    get assigned_courier_orders_path, api_token: @courier.api_token
    assert_response :success
  end

  test 'should assign order' do
    patch assign_courier_order_path(@new_order), api_token: @courier.api_token
    assert_response :ok
    assert_equal @courier, @new_order.reload.courier
  end

  test 'should update order' do
    patch courier_order_path(@assigned_order), api_token: @courier.api_token, order: {
      status: 'delivered'
    }
    assert_response :ok
    assert @assigned_order.reload.status.delivered?
  end

  test 'should authorize assign' do
    patch assign_courier_order_path(@assigned_order), api_token: @courier.api_token
    assert_response :forbidden
  end

  test 'should authorize update' do
    courier = couriers(:baz)
    patch assign_courier_order_path(@assigned_order), api_token: courier.api_token
    assert_response :forbidden
  end
end
