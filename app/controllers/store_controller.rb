class StoreController < ApplicationController
  def index
  	@categories = Category.all
  	@items = Item.where('inventory > 0')
  end
end
