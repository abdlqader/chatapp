require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  self.use_instantiated_fixtures = true
  test "Should get index" do
    get application_chat_messages_url(application_id: @applicationOne.token,chat_id: @chatOne.number)
    assert_response :success 
    assert_equal Message.where(chat_id: @chatOne.id).as_json(:except => [:id, :chat_id]), JSON.parse(response.body)
  end
  test "Should create message" do
    post application_chat_messages_url(application_id: @applicationOne.token,chat_id: @chatOne.number)
    assert_response :success 
    assert_not_nil JSON.parse(response.body)['number']
  end
end
