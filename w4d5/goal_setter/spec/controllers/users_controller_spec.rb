require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders new users page" do
      get :new, params: { user: {} }

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    # it "saves user to database" do
    #   post :create, user: {username: 'jack_bruce', password: 'password' }
    #   expect(User.find_by_username('jack_bruce').nil?).to be(false)
    # end
    context "with valid params" do
      it "redirects to user show page" do
        post :create, params: { user: { username: 'jack_bruce', password: 'password' } }
        expect(response).to redirect_to("show")
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid params" do
      it "redirects to users page" do
        post :create, params: {user: { username: 'jack_bruce' }}
        expect(response).to redirect_to("new")
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #edit" do
    it "renders edit user page" do
      User.create!(username: 'sean', password: 'password')
      get :edit, id: 1

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "redirects to user show page" do
        patch :update, params: { user: { username: 'isak', password: 'password' } }
        expect(response).to redirect_to("show")
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid params" do
      it "redirects to users page" do
        patch :update, params: {user: { username: 'jack_bruce' }}
        expect(response).to redirect_to("edit")
        expect(response).to have_http_status(200)
      end
    end
  end
end
