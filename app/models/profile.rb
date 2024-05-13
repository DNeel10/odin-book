class Profile < ApplicationRecord
  belongs_to :user

  accepts_nested_attributes_for :user

  def formatted_date
    birthday.strftime("%m/%d/%Y") unless !birthday
  end
end
