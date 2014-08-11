require 'spec_helper'

describe DefinitionsController do
  context "users try to access definitions" do
    before do
      user1 = create_user("other@other.com")
      user2 = create_user("bob@bob.com")

      @glossary1 = create_public_glossary(user1, "Other Test 1")
      create_bulk_definitions_for(@glossary1)
      @definition = Definition.all.first

      sign_in(user2)
    end

    {
      edit: :get,
      update: :put,
      destroy: :delete
    }.each do |action, method|
      it "can't access #{action} action for other people's glossaries" do
        send(method, action, id: @definition.id)
        expect(response).to redirect_to glossary_path(@glossary1)
        expect(flash[:alert]).to eq "This action is not available"

      end
    end

  end
end