require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "renders new session page" do
      get :new, params: {}

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to show users page" do
        post :create, params: { user: { username: 'jack_bruce', password: 'password' } }

        expect(response).to redirect_to(User.find_by(username: 'jack_bruce'))
        expect(response).to have_http_status(200)
      end
    end
    context "with invalid params" do
      it "redirects to new session page" do
        post :create, params: { user: { username: 'jack_bruce' } }

        expect(response).to redirect_to('new')
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to the new session page"
  end
end
