class AddUserRefToProfileQuiz < ActiveRecord::Migration
  def change
    add_reference :profile_quizzes, :users, index: true, foreign_key: true
  end
end
