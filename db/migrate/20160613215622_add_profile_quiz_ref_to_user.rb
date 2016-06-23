class AddProfileQuizRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :profileQuiz, index: true, foreign_key: true
  end
end
