class Reservation < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  before_validation :create_if_not_exist, on: :create

  enum status: {
    booked:     0,
    seated:     1,
    cancelled:  2,
  }

  def create_if_not_exist
    # Find or create the user by name and mobile
    if new_user = User.find_by_name_and_mobile(user.name, user.mobile)
      self.user = new_user
    elsif user && user.persisted? && user.changed?
      # New condition: if user is already allocated to reservation, but is changed, create a new user.
      self.user = User.new(name: user.name, mobile: user.mobile)
    else
      # else create a new user
      self.user.save!
    end
  end
end
