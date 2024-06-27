# This migration comes from ai_engine (originally 20240530135629)
class CreateAIEngineMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_engine_messages do |t|
      t.string :remote_id
      t.references :ai_engine_run, foreign_key: true
      t.references :messageable, polymorphic: true
      t.integer :role, null: false, default: 0
      t.string :content, null: false
      t.string :model
      t.integer :prompt_token_usage
      t.integer :completion_token_usage

      t.timestamps
    end
  end
end
