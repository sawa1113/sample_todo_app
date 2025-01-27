require 'rails_helper'

RSpec.describe Todo, type: :model do
    it "titleとdescriptionが正常に登録される場合" do
        todo = Todo.new(title: "サンプルタイトル", description: "サンプル説明")
        expect(todo).to be_valid
    end
    
    it "titleがnilの場合(空チェック)" do
        todo = Todo.new(title: nil, description: "サンプル説明")
        expect(todo).not_to be_valid
    end

    it "descriptionがnilの場合(空チェック)" do
        todo = Todo.new(title: "サンプルタイトル", description: nil)
        expect(todo).not_to be_valid
    end

    it "titleが50文字以内(文字数制限チェック)" do
        todo = Todo.new(title: "a" * 51, description: "サンプル説明")
        expect(todo).not_to be_valid
    end

    it "タイトルがないと無効です" do
        todo = Todo.new(title: nil, description: "サンプル説明")
        todo.valid?
        expect(todo.errors[:title]).to include("を入力してください")
    end
end