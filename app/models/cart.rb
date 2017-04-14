class Cart < ActiveRecord::Base
	belongs_to :user
	has_many :line_items
	has_many :items, through: :line_items

	def total
		self.line_items.reduce(0) { |sum, line_item| sum + line_item.quantity * line_item.item.price }
	end

	def add_item(item_id)
    if item_ids.include?(item_id.to_i)
      current_line_item = line_items.find_by(item_id: item_id)
      current_line_item.quantity += 1
      current_line_item
    else
      line_items.build(item_id: item_id)
    end
  end

  def checkout
    self.status = "submitted"
    line_items.each do |line_item|
      line_item.item.inventory = line_item.item.inventory - line_item.quantity
      line_item.item.save
    end
    user.remove_cart
    self.save
  end
end

