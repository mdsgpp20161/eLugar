class AddUberToProfileQuizzes < ActiveRecord::Migration
  def change
    add_column :profile_quizzes, :uber, :integer
  end
end
