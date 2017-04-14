class Item < ActiveRecord::Base
	belongs_to :category
	has_many :line_items

	def self.available_items
		self.all.collect { |item| item if item.inventory > 0 }.compact
	end
end
