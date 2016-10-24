class Order < ActiveRecord::Base
  serialize :result

  has_many :line_items
end
