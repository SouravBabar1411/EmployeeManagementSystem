# == Schema Information
#
# Table name: notifications
#
#  id               :bigint           not null, primary key
#  title            :string           not null
#  notificable_id   :bigint           not null
#  notificable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Notification < ApplicationRecord
  ## Associations
  belongs_to :notificable, polymorphic: true
end
