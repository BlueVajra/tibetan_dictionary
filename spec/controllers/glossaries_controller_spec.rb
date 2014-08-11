require 'spec_helper'

describe GlossariesController do
  context "users try to access glossary actions" do
    before do
      user1 = create_user("other@other.com")
      user2 = create_user("bob@bob.com")
      sign_in(user2)
      @glossary1 = create_public_glossary(user1, "Other Test 1")
    end

    {
      edit: :get,
      update: :put,
      import_form: :get,
      import: :post
    }.each do |action, method|
      it "can't access #{action} action for other people's glossaries" do
        send(method, action, id: @glossary1.id)
        expect(response).to redirect_to glossary_path(@glossary1)
        expect(flash[:alert]).to eq "This action is not available"
      end
    end

    {
      show: :get
    }.each do |action, method|
      it "can access #{action} action for other people's glossaries" do
        send(method, action, id: @glossary1.id)
        expect(response.status).to eq 200
      end
    end

  end
end
