class AddAttachmentToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :attachment, :string
  end
end
