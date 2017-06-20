# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  CAT_COLORS = %w(black tortoise tiger cow Pallas's)

  validates :name, presence: true
  validates :birth_date, presence: true
  validates :name, presence: true
  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: ["M", "F"]

  def age
    time_ago_in_words(birth_date)
  end
end
