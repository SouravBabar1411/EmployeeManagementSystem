# == Schema Information
#
# Table name: global_configurations
#
#  id           :bigint           not null, primary key
#  config_key   :string           not null
#  config_value :string           not null
#  company_id   :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class GlobalConfiguration < ApplicationRecord
  ## Associations
  belongs_to :company
end
