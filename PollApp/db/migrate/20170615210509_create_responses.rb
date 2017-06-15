class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.integer :answer_choice_id, null: false
      t.integer :question_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
