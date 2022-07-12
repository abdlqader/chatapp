require "test_helper"

class ChatTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true
  test "Should not save duplicate number in chat" do
    application = Chat.new(number: @chatOne.number, application_id: @chatOne.application)
    assert_not application.save, "Saved the chat with duplicate number"
  end
end
