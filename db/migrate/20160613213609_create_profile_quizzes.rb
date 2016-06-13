class CreateProfileQuizzes < ActiveRecord::Migration
  def change
    create_table :profile_quizzes do |t|
      t.integer :answer1
      t.integer :answer2
      t.integer :answer3
      t.integer :answer4
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
