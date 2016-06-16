class ProfileQuiz < ActiveRecord::Base
	belongs_to :user
	validates :uber,:population,:demographic_density,:area, presence: true
end
