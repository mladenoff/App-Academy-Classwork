require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryGirl.build(:user,
      email: "johnathan@fakesite.com",
      password: "good_password")
  end

  it { should validate_presence_of :email }
  it { should validate_presence_of :password_digest }
  it { should validate_length_of(:password).is_at_least 6 }

  describe "#is_password?" do
    it "verifies that a password is correct" do
      expect(user.is_password?("good_password")).to be true
    end
  end
end
