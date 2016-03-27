class Comment < ActiveRecord::Base
  belongs_to :task

  validates :task, presence: true
  validates :body, presence: true
end
