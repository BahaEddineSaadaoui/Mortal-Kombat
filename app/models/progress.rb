class Progress < ApplicationRecord
	has_many :weapons through: :progressweapons
end