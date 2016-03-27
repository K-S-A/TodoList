class Task < ActiveRecord::Base
  include RankedModel

  belongs_to :project
  ranks :priority, with_same: :project_id

  validates :name, presence: true,
                   uniqueness: { scope: :project_id,
                                 case_sensitive: false }

  default_scope { rank(:priority) }
end
