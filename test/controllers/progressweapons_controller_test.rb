require 'test_helper'

class ProgressweaponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @progressweapon = progressweapons(:one)
  end

  test "should get index" do
    get progressweapons_url
    assert_response :success
  end

  test "should get new" do
    get new_progressweapon_url
    assert_response :success
  end

  test "should create progressweapon" do
    assert_difference('Progressweapon.count') do
      post progressweapons_url, params: { progressweapon: {  } }
    end

    assert_redirected_to progressweapon_url(Progressweapon.last)
  end

  test "should show progressweapon" do
    get progressweapon_url(@progressweapon)
    assert_response :success
  end

  test "should get edit" do
    get edit_progressweapon_url(@progressweapon)
    assert_response :success
  end

  test "should update progressweapon" do
    patch progressweapon_url(@progressweapon), params: { progressweapon: {  } }
    assert_redirected_to progressweapon_url(@progressweapon)
  end

  test "should destroy progressweapon" do
    assert_difference('Progressweapon.count', -1) do
      delete progressweapon_url(@progressweapon)
    end

    assert_redirected_to progressweapons_url
  end
end
