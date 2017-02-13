# == Schema Information
#
# Table name: welcome_screens
#
#  id                   :integer          not null, primary key
#  image_open           :string
#  image_open_enabled   :boolean          default("false")
#  image_closed         :string
#  image_closed_enabled :boolean          default("false")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class WelcomeScreen < ActiveRecord::Base
  mount_uploader :image_open, ImageUploader
  mount_uploader :image_closed, ImageUploader

  def self.instance
    first or create
  end
end
