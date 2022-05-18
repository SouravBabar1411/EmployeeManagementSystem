# == Schema Information
#
# Table name: contact_infos
#
#  id               :bigint           not null, primary key
#  phone_number     :integer          not null
#  contactable_id   :bigint
#  contactable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class ContactInfo < ApplicationRecord
  ## Associations
  belongs_to :contactable, polymorphic: true
end
