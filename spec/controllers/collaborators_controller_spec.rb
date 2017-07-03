require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let(:premium_user) { User.create!(email: "premium_user@bloccit.com", password: "helloworld", role: "premium") }
  let(:my_collaborator) { User.create!(email: "user@bloccit.com", password: "helloworld") }
  let(:my_wiki) { Wiki.create!(title: "This is a Title", body: "A sex columnist, Carrie Bradshaw, and her three friends -- Samantha, Charlotte and Miranda -- explore Manhattan's dating scene, chronicling the mating habits of single New Yorkers. Not surprisingly, the ladies have a number of beaus throughout the series' run.", user: premium_user, private: true) }
  let(:collaborator)  { Collaborator.create!(wiki_id: my_wiki.id, user_id: my_collaborator.id) }

  before(:each) do
    sign_in premium_user
  end

  describe "POST create" do
    it "increases the number of collaborator by 1" do
      expect{ post :create, wiki_id: my_wiki.id, user_id: my_collaborator.id }.to change(Collaborator,:count).by(1)
    end


    it "redirects to wiki show view" do
      post :create, wiki_id: my_wiki.id, user_id: my_collaborator.id
      expect(response).to redirect_to [my_wiki]
    end
  end

  describe "DELETE destroy" do
    it "deletes the collaborator" do
      delete :destroy, wiki_id: my_wiki.id, id: collaborator.id
      count = Collaborator.where({id: collaborator.id}).count
      expect(count).to eq 0
    end

    it "redirects to the wiki index view" do
    delete :destroy, wiki_id: my_wiki.id, id: collaborator.id
    expect(response).to redirect_to my_wiki
  end
end
