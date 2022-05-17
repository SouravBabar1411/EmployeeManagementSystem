# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_id   :bigint
#  addressable_type :string
#  address_line_1   :string           not null
#  address_line_2   :string           not null
#  city             :string           not null
#  state            :string           not null
#  country          :string           not null
#  zipcode          :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
end
