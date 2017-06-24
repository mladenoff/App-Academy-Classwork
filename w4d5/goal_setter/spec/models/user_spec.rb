require 'rails_helper'

RSpec.describe User, type: :model do
  #
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of :username }
  it { should validate_presence_of :password_digest }

  it { should validate_uniqueness_of :username }
  it { should validate_uniqueness_of :session_token }

  it "should ensure session token" do
    user = User.new(username: 'mittens', password: 'password')
    expect(user).to be_valid
  end

  describe "::find_by_credentials" do
    let(:user) { FactoryGirl.build(:user) }
    it "finds a user with username and password" do
      user = User.find_by_credentials(username: 'jack_bruce', password: 'password')
      expect(user.nil?).to be(false)
    end
    it "will not return a user with incorrect password" do
      user = User.find_by_credentials(username: 'jack_bruce', password: 'i_hate_eric')
      expect(user.nil?).to be(true)
    end
  end
end
