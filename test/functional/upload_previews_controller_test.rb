require 'test_helper'

class UploadPreviewsControllerTest < ActionController::TestCase
  setup do
    @upload_preview = upload_previews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:upload_previews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create upload_preview" do
    assert_difference('UploadPreview.count') do
      post :create, :upload_preview => @upload_preview.attributes
    end

    assert_redirected_to upload_preview_path(assigns(:upload_preview))
  end

  test "should show upload_preview" do
    get :show, :id => @upload_preview.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @upload_preview.to_param
    assert_response :success
  end

  test "should update upload_preview" do
    put :update, :id => @upload_preview.to_param, :upload_preview => @upload_preview.attributes
    assert_redirected_to upload_preview_path(assigns(:upload_preview))
  end

  test "should destroy upload_preview" do
    assert_difference('UploadPreview.count', -1) do
      delete :destroy, :id => @upload_preview.to_param
    end

    assert_redirected_to upload_previews_path
  end
end
