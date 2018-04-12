# frozen_string_literal: true

require_relative "test_helper"

class AppServiceTest < Minitest::Test
  def test_render_root
    get "/"
    assert_equal "Hello AppService template", json_response["hello"]
  end
end
