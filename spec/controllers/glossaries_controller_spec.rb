require 'spec_helper'

describe GlossariesController do
  before do
    @user1 = create_user("other@other.com")
    user2 = create_user("bob@bob.com")
    sign_in(user2)
  end

  context "users try to access public glossary actions" do
    before do
      @public_glossary = create_public_glossary(@user1)
    end

    {
      edit: :get,
      update: :put,
      import_form: :get,
      import: :post
    }.each do |action, method|
      it "can't access #{action} action" do
        send(method, action, id: @public_glossary.id)
        expect(response).to redirect_to glossary_path(@public_glossary)
        expect(flash[:alert]).to eq "This action is not available"
      end
    end

    {
      show: :get
    }.each do |action, method|
      it "can access #{action} action" do
        send(method, action, id: @public_glossary.id)
        expect(response.status).to eq 200
      end
    end

  end

  context "users try to access private glossary actions" do
    before do
      @private_glossary = create_private_glossary(@user1)
    end

    {
      edit: :get,
      update: :put,
      import_form: :get,
      import: :post,
      show: :get
    }.each do |action, method|
      it "can't access #{action} action" do
        send(method, action, id: @private_glossary.id)
        expect(response.status).to eq 404
      end
    end

  end
end
