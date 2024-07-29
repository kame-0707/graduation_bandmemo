class Like < ApplicationRecord
    belongs_to :user
    belongs_to :group
    belongs_to :summary
end
