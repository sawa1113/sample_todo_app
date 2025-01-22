class TodosController < ApplicationController
  before_action :authenticate_user! # ログインしていない場合アクセス不可
  before_action :set_todo, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy remove_attachment]

  # CanCanCanによる権限管理を適用
  load_and_authorize_resource except: :index

  def index
    @pagy, @todos = pagy(current_user.todos.accessible_by(current_ability), items: 10) # ログインユーザーのタスクのみ
  end

  def show
  end

  def new
    @todo = current_user.todos.build # ログインユーザーのタスクとして初期化
  end

  def edit
  end

  def create
    @todo = current_user.todos.build(todo_params) # ログインユーザーに関連付け

    if @todo.save
        redirect_to @todo, notice: 'Todoを作成しました。'
    else
        render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: 'Todoを更新しました。'
    else
      flash.now[:alert] = 'Todoの更新に失敗しました。入力内容を確認してください。'
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to todos_path, alert: '指定されたTodoは見つかりませんでした。'
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: 'Todoを削除しました。'
  end

  #画像削除アクション
  def remove_attachment
    if @todo.remove_attachment
      redirect_to @todo, notice: "添付ファイルが削除されました。"
    else
      redirect_to @todo, notice: "添付ファイルの削除に失敗しました。"
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def authorize_user
    redirect_to todos_path, alert: '権限がありません。' unless @todo.user == current_user
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :completed, :attachment)
  end
end
