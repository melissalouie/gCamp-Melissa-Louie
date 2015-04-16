require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do

  context "with valid params" do

    before(:each) do
      @user = User.create(first_name: 'Melissa', last_name: 'Louie', email: 'melissa@mail.com', password: 'password', admin: true)
      @user_2 = User.create(first_name: 'Buddy', last_name: 'Louie', email: 'buddy@mail.com', password: 'password', admin: true)
      session[:user_id] = @user.id
      @project = Project.create(name: 'Test Project')
      @membership = Membership.create(user_id: @user.id, project_id: @project.id, role: true)
    end

    it "creates the requested membership" do
      post :create, project_id: @project.id, :membership => {id: @membership.id, user_id: @user.id, role: true}
      expect(@membership.role).to eq(true)
    end

    # it "updates the requested membership" do
    #   put :update, project_id: @project.id, id: @membership.id, :membership => {id: @membership.id, user_id: @user_2.id }
    #   @membership.reload
    #   expect(@membership.user_id).to eq(@user_2.id)
    # end

    it "deletes the requested membership" do
      memberships = Membership.count
      delete :destroy, project_id: @project.id, id: @membership.id
      expect(Membership.count).to eq(memberships - 1)
    end

  end

end
