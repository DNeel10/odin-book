class Profile < ApplicationRecord
  belongs_to :user

  def formatted_date
    birthday.strftime("%m/%d/%Y")
  end
end
