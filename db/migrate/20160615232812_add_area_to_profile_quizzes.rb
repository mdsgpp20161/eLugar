class AddAreaToProfileQuizzes < ActiveRecord::Migration
  def change
    add_column :profile_quizzes, :area, :integer
  end
end
