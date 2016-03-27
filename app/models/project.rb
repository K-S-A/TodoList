class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true,
                    length: { minimum: 5,
                              maximum: 55 },
                    uniqueness: { scope: :user_id,
                                  case_sensitive: false }
  validates :description, length: { maximum: 250 }
end
