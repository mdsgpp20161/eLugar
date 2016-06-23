class AddDemographicDensityToProfileQuizzes < ActiveRecord::Migration
  def change
    add_column :profile_quizzes, :demographic_density, :integer
  end
end
