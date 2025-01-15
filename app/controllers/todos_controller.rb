class TodosController < ApplicationController
  def index
    @pagy, @todos = pagy(Todo.all, items: 10)
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
        redirect_to @todo, notice: 'Todoを作成しました。'
    else
        render :new, status: :unprocessable_entity
    end
  end

  def update
    @todo = Todo.find(params[:id])
  
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
    @todo = Todo.find(params[:id])
    @todo.destroy

    redirect_to todos_path, notice: 'Todoを削除しました。'
  end

  #画像削除アクション
  def remove_attachment
    @todo = Todo.find(params[:id])

    if @todo.remove_attachment
      redirect_to @todo, notice: "添付ファイルが削除されました。"
    else
      redirect_to @todo, notice: "添付ファイルの削除に失敗しました。"
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :completed, :attachment)
  end
end
