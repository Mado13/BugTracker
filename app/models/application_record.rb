class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :lead_developer_data, ->(id) { where(lead_developer_id: id) }
end
