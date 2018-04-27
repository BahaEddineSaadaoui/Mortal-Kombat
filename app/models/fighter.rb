class Fighter < ApplicationRecord
  has_one :photo, :dependent => :destroy
  accepts_nested_attributes_for :photo , allow_destroy: true

  def is_stronger enemy
    (experience - enemy.experience) > 0
  end
end