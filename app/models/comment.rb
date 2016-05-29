class Comment < ActiveRecord::Base
  belongs_to :city

  validates :body, presence: true
  validates :commenter, presence: true
end
