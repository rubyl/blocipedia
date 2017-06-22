require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "user@bloccit.com", password: "password") }

  describe "attributes" do
    it "should have name and email attributes" do
       expect(user).to have_attributes(email: "user@bloccit.com")
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to standard" do
      expect(user).to respond_to(:standard?)
    end

    it "responds to premium" do
      expect(user).to respond_to(:premium?)
    end
  end

  describe "roles" do
    it "is standard by default" do
      expect(user.role).to eql("standard")
    end

    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end

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
