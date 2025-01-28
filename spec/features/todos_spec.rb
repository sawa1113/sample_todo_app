RSpec.describe "Todo management", type: :feature do
    let(:user) { FactoryBot.create(:user) }
  
    before do
      # ログイン画面に遷移
      visit new_user_session_path
      expect(page).to have_content("ログイン")  # ログインページの見出しを確認

      # メールアドレスとパスワードを入力
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
  
      # ログイン後、プロフィールページに遷移しているか確認
      expect(page).to have_current_path(root_path)  # ユーザープロフィールページに遷移していることを確認
    end
  
    it "タイトルなしでToDoを作成するとエラーメッセージが表示される" do
      # プロフィール画面からToDo画面に遷移
      click_link "Todo画面へ"  # プロフィール画面のリンクをクリック

      click_link "新規作成"  # プロフィール画面のリンクをクリック
  
      # Todoの作成フォームに遷移後、タイトルなしでToDoを作成
      fill_in "todo[title]", with: ""  # タイトルを空で入力
      fill_in "todo[description]", with: "Test Description"
      click_button "登録する"
  
      # エラーメッセージが表示されることを確認
      expect(page).to have_content("タイトルを入力してください")
    end
end