class City < ActiveRecord::Base
	validates :name, presence: true
	validates :population, presence: true
	validates :demographic_density, presence: true
	validates :area, presence: true
	validates :fleet, presence: true
	validates :idh, presence: true
	validates :gini, presence: true
	validates :health, presence: true
	validates :violence, presence: true
	validates :image, presence: true
end
