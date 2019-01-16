require 'test_helper'

class PlayEntryControllerTest < ActionDispatch::IntegrationTest
  def setup
    @content = Content.new
  end

  test "should get home" do
    get root_url
    assert_response :success
  end

  # URLバリデーション
  test "input url validation" do
    url = 'http://example.com'

    post input_path(@content), params: { content: { url: url } }

    assert flash.empty?

    url = 'https://www.example.com'
    post input_path(@content), params: { content: { url: url } }

    assert flash.empty?

    url = 'http.example.com'
    post input_path(@content), params: { content: { url: url } }

    assert_not flash.empty?
  end
end
