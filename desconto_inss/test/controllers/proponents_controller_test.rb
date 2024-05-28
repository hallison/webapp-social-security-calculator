require "test_helper"

class ProponentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get proponents_index_url
    assert_response :success
  end

  test "should get new" do
    get proponents_new_url
    assert_response :success
  end

  test "should get create" do
    get proponents_create_url
    assert_response :success
  end

  test "should get show" do
    get proponents_show_url
    assert_response :success
  end

  test "should get edit" do
    get proponents_edit_url
    assert_response :success
  end

  test "should get update" do
    get proponents_update_url
    assert_response :success
  end

  test "should get destroy" do
    get proponents_destroy_url
    assert_response :success
  end
end
