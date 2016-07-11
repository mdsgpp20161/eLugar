class AddPopulationToProfileQuizzes < ActiveRecord::Migration
  def change
    add_column :profile_quizzes, :population, :integer
  end
end
