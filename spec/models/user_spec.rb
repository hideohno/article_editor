# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  context "nameが入力されているとき" do
    it "ユーザーが作成される" do
      # user = User.new(name: "taro", email: "abc@test.com", password: "pass123")
      user = build(:user)
      expect(user).to be_valid
    end
  end

  context "nameが入力されていないとき" do
    it "ユーザーが作成できない" do
      # user = User.new(name: "", email: "abc@test.com", password: "pass123")
      user = build(:user, name: nil)
      expect(user).to be_invalid
      # expect(user.errors.details[:name][0][:error]).to eq :blank
    end
  end

  # context "nameがユニークなとき" do
  #   it "ユーザーが作成される" do
  #     user = User.new(name: "taro", email: "abc@test.com", password: "pass123")
  #     expect(user).to be_valid
  #   end
  # end

  context "nameがユニークでないとき" do
    it "ユーザー作成できない" do
      # User.create!(name: "taro", email: "abc@test.com", password: "pass123")
      # user = User.new(name: "taro", email: "def@test.com", password: "pass456")
      create(:user, name: "namae")
      user = build(:user, name: "namae")
      expect(user).to be_invalid
      # expect(user.errors.details[:name][0][:error]).to eq :taken
    end
  end

  context "emailが入力されていないとき" do
    it "ユーザー作成できない" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      # expect(user.errors.details[:email][0][:error]).to eq :blank
    end
  end

  context "passwordが入力されていないとき" do
    it "ユーザー作成できない" do
      user = build(:user, password: nil)
      expect(user).to be_invalid
      # expect(user.errors.details[:password][0][:error]).to eq :blank
    end
  end
end
