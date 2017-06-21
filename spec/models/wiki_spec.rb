require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(email: "user@bloccit.com", password: "helloworld") }
  let(:wiki) { Wiki.create!(title: "This is a Title", body: "A sex columnist, Carrie Bradshaw, and her three friends -- Samantha, Charlotte and Miranda -- explore Manhattan's dating scene, chronicling the mating habits of single New Yorkers. Not surprisingly, the ladies have a number of beaus throughout the series' run.", user: user, private: false) }

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "has a title, body, and user attribute" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: user)
    end
  end


end
