require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let (:my_wiki) { Wiki.create!(title: "This is a title", body: "This is the body", private: false) }

  context "guest" do
    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "renders the #show view" do
        get :show, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "assigns my_wiki to @wiki" do
        get :show, {id: my_wiki.id}
        expect(assigns(:wiki)).to redirect_to(new_user_session_path)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, {id: my_wiki.id}, wiki: {title: "Meow", body: "The cat jumped over the moon."}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = "New Title"
        new_body = "New Body"

        put :update, id: my_wiki, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "standard user doing CRUD on a post they own" do
    before do
      user = User.create!(email: "user@bloccit.com", password: "helloworld", role: :standard)
      sign_in user
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: my_wiki.id}
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, {id: my_wiki.id}
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: {title: "hello world", body: "this is the world"}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = "This is a new title"
        new_body = "This is my new body"

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated post" do
        new_title = "This is a new title"
        new_body = "This is my new body"

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_wiki]
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, id: my_wiki.id
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end
    end
  end

  context "admin user doing CRUD on a post they don't own" do
    before do
      user = User.create!(email: "user@bloccit.com", password: "helloworld", role: :admin)
      sign_in user
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: my_wiki.id}
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, {id: my_wiki.id}
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, {id: my_wiki.id}
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new, {id: my_wiki.id}
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Wiki by 1" do
        expect{ post :create, wiki: {title: "Some title", body: "Some Body"} }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: "Some title", body: "Some Body"}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: "Some title", body: "Some Body"}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {id: my_wiki.id}
        expect(response).to render_template :edit
      end

      it "assigns post to be updated to @post" do
        get :edit, {id: my_wiki.id}
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
      end
    end

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = "This is a new title"
        new_body = "This is my new body"

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated post" do
        new_title = "This is a new title"
        new_body = "This is my new body"

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_wiki]
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, id: my_wiki.id
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end
    end
  end
end
