require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should upload pdf" do
    get :download_pdf
    uploaded_file = ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("test/fixtures/ReferenciasTest.pdf"))
    )
    assert_not nil
    assert_response :success
  end
end
