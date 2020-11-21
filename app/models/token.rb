class Token < ApplicationRecord
  enum status: %i[active blocked]
end
