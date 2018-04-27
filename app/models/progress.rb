class Progress < ApplicationRecord
	has_many :weapons, through: :progressweapons

	belongs_to :fighter
end