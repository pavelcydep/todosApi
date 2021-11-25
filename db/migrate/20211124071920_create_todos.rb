class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :text
      t.boolean :isCompleted
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
