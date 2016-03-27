class Task < ActiveRecord::Base
  include RankedModel

  belongs_to :project
  ranks :priority, with_same: :project_id

  has_many :comments, dependent: :destroy

  validates :project, presence: true
  validates :name, presence: true,
                   uniqueness: { scope: :project_id,
                                 case_sensitive: false }

  default_scope { rank(:priority) }
end
