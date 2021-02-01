class Book < ApplicationRecord
    validates :Title, :Body, presence: true

end
