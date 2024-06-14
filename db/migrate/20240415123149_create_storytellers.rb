class CreateStorytellers < ActiveRecord::Migration[7.1]
  def change
    create_table :storytellers do |t|
      t.references :user, null: false, foreign_key: true

      t.string :name, null: false
      t.string :model, null: false
      t.string :instructions, null: false
      t.text :description, null: false
      t.integer :max_prompt_tokens, null: false
      t.integer :max_completion_tokens, null: false

      t.timestamps
    end
  end
end
