require "test_helper"
class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  self.use_instantiated_fixtures = true
  test "Should get index" do
    get applications_url
    assert_response :success 
    assert_equal Application.all.as_json(:except => :id), JSON.parse(response.body)
  end
  test "Should show application" do
    get application_url(@applicationOne.token)
    assert_response :success 
    assert_equal @applicationOne.as_json(:except => :id), JSON.parse(response.body)
  end
  test "Should create application" do
    post applications_url, params: { name: 'test'}
    assert_response :success 
    assert_equal 'test', JSON.parse(response.body)['name']
    assert_not_nil JSON.parse(response.body)['token']
  end
end
