require 'test_helper.rb'

class ProjectsControllerTest < ActionController::TestCase

    test "index" do
      get :index
      assert_response :success
    end

    test "new" do
      get :new
      assert_response :success
    end

    it "show" do
      get :show
      assert_response :success
    end

    it "edit" do
      get :edit
      assert_response :success
    end

    it "destroy" do
      get :destroy
      assert_response :success
    end

    test "create" do
      get :create
      assert_response :success
    end

    test "update" do
      get :update
      assert_response :success
    end

end
