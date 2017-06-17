require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "user@bloccit.com", password: "password") }

  describe "invalid user" do
    let(:user_with_invalid_email) { User.new(email: "", password: 'password') }

    it "should be an invalid user due to blank email" do
      puts user_with_invalid_email
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "duplicate email" do
    before do
      user
    end

    let(:duplicate_user) { User.new(email: "user@bloccit.com", password: "password")}
    it "should be an invalid due to duplciate email" do
      expect(duplicate_user).to_not be_valid
    end
  end

  describe "after create" do
    before do
      @new_user = User.new(email: 'newuser@example.com', password: 'helloworld')
    end

    it "sends an email to user who register" do
      expect(WelcomeMailer).to receive(:welcome_send).with(@new_user).and_return(double(deliver_now: true))
      @new_user.save!
    end

    it "does not send emails to user who doesn't register" do
      expect(WelcomeMailer).not_to receive(:welcome_send).with(@new_user)
    end
  end
end
