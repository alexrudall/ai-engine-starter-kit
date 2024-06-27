# This migration comes from ai_engine (originally 20240619150010)
class CreateAIEngineChats < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_engine_chats do |t|
      t.belongs_to :chattable, polymorphic: true

      t.timestamps
    end
  end
end
