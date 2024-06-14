# This migration comes from ai_engine (originally 20240528153439)
class CreateAIEngineAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_engine_assistants do |t|
      t.string :remote_id
      t.belongs_to :assistable, polymorphic: true

      t.timestamps
    end

    add_index :ai_engine_assistants, %i[assistable_type assistable_id remote_id], unique: true
  end
end
