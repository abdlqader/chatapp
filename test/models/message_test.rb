require "test_helper"

class MessageTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true
  test "Should not save duplicate number in message" do
    application = Chat.new(number: @messageOne.number, application_id: @messageOne.chat)
    assert_not application.save, "Saved the message with duplicate number"
  end
end
