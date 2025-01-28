require 'rails_helper'

RSpec.describe TodosController, type: :request do
  # ユーザーと他のユーザーを事前に作成
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  # Fakerを使用した一貫性のあるテストデータ
  let!(:generated_title) { Faker::Lorem.sentence }
  let!(:generated_description) { Faker::Lorem.paragraph }

  # ログイン設定
  before do
    sign_in user
  end

  describe "POST /todos" do
    it "createアクションにリクエストすると正常にレスポンスが返ってくる" do
      test_title = "固定タイトル"
      test_description = "固定説明文"
      
      post todos_path, params: { todo: { title: test_title, description: test_description, completed: false } }
      
      new_todo = Todo.last
      expect(new_todo.title).to eq(test_title)
      expect(new_todo.description).to eq(test_description)
      expect(new_todo.user).to eq(user) # user はログイン中のユーザー
    end       
  end  
end
