require "test_helper"

class ApplicationTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true
  test "Should not save application without name" do
    application = Application.new
    assert_not application.save, "Saved the application without a name"
  end
  test "Should not save duplicate token in aplication" do
    application = Application.new(token: @applicationOne.token, name: @applicationOne.name)
    assert_not application.save, "Saved the application with duplicate token"
  end
end
