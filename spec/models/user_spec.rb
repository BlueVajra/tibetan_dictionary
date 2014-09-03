require 'spec_helper'

describe User do
  context "validations" do
    before do
      @user = User.create(username: "Joe", email: "joe@joe.com", password: "password1")
      @user.save
      expect(@user).to be_valid
    end

    it "ensures username is present" do
      @user = User.new(username: "", email: "joe2@joe.com", password: "password1")
      expect(@user).to_not be_valid
    end

    it "ensures username is unique" do
      @user = User.new(username: "Joe", email: "joe2@joe.com", password: "password1")
      expect(@user).to_not be_valid
    end

    it "ensures usernames with whitespace at stripped before validation" do
      @user = User.new(username: "Joe ", email: "joe2@joe.com", password: "password1")
      expect(@user).to_not be_valid
    end
  end
end
