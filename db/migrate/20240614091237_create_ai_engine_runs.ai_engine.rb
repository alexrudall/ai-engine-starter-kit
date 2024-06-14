# This migration comes from ai_engine (originally 20240530130834)
class CreateAIEngineRuns < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_engine_runs do |t|
      t.string :remote_id
      t.references :ai_engine_assistant, foreign_key: true
      t.references :ai_engine_assistant_thread, foreign_key: true
      t.integer :prompt_token_usage
      t.integer :completion_token_usage

      t.timestamps
    end
  end
end
