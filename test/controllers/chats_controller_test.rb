require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  self.use_instantiated_fixtures = true
  test "Should get index" do
    get application_chats_url(application_id: @applicationOne.token)
    assert_response :success 
    assert_equal Chat.where(application_id: @applicationOne.id).all.as_json(:except => [:id, :application_id]), JSON.parse(response.body)
  end
  test "Should create chat" do
    post application_chats_url(application_id: @applicationOne.token)
    assert_response :success 
    assert_not_nil JSON.parse(response.body)['number']
  end
end
