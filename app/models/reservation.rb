class Reservation < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  before_validation :create_if_not_exist

  def create_if_not_exist
    # Find or create the user by name
    if new_user = User.find_by_mobile(user.mobile)
      self.user = new_user
    elsif user && user.persisted? && user.changed?
      # New condition: if user is already allocated to post, but is changed, create a new user.
      self.user = User.new(name: user.name, mobile: user.mobile)
    else
      # else create a new user
      self.user.save!
    end
  end
end
