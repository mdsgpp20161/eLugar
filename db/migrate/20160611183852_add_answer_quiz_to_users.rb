class AddAnswerQuizToUsers < ActiveRecord::Migration
  def change
    add_column :users, :answer_quiz, :integer
  end
end
