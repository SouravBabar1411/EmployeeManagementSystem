# == Schema Information
#
# Table name: notifications
#
#  id               :bigint           not null, primary key
#  title            :string
#  notificable_id   :bigint
#  notificable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Notification < ApplicationRecord
  belongs_to :notificable, polymorphic: true
end
