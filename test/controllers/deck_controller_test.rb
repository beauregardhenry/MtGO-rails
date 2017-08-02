require 'test_helper'

class DeckControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get deck_index_url
    assert_response :success
  end

end
