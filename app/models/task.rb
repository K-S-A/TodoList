class Task < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true,
                   uniqueness: { scope: :project_id,
                                 case_sensitive: false }
end
