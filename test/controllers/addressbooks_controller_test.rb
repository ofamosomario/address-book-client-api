require "test_helper"

class AddressbooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @addressbook = addressbooks(:one)
  end

  test "should get index" do
    get addressbooks_url, as: :json
    assert_response :success
  end

  test "should create addressbook" do
    assert_difference('Addressbook.count') do
      post addressbooks_url, params: { addressbook: { user_id: @addressbook.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show addressbook" do
    get addressbook_url(@addressbook), as: :json
    assert_response :success
  end

  test "should update addressbook" do
    patch addressbook_url(@addressbook), params: { addressbook: { user_id: @addressbook.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy addressbook" do
    assert_difference('Addressbook.count', -1) do
      delete addressbook_url(@addressbook), as: :json
    end

    assert_response 204
  end
end
