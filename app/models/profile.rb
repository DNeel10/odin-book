class Profile < ApplicationRecord
  belongs_to :user

  def formatted_date
    birthday.strftime("%m/%d/%Y") unless !birthday
  end
end
