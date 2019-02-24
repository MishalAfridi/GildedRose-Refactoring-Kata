class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    decreasing_quality_items = []
    increasing_quality_items = []
    conjured_items = []

    sort_items(decreasing_quality_items, increasing_quality_items, conjured_items)

    decrease_items_quality(decreasing_quality_items)
    increase_items_quality(increasing_quality_items)
    decrease_conjured_items_quality(conjured_items)
  end

  def sort_items(decreasing_quality_items, increasing_quality_items, conjured_items)
    @items.each do |item|
      if item.name.include?("Conjured")
        conjured_items << item
      elsif item.name.eql?("Aged Brie") || item.name.eql?("Backstage passes to a TAFKAL80ETC concert")
        increasing_quality_items << item
      elsif !item.name.eql?("Sulfuras, Hand of Ragnaros")
        decreasing_quality_items << item
      end
    end
  end

  def decrease_items_quality(decreasing_quality_items)
    decreasing_quality_items.each do |item|
      if item.quality > 0
        item.quality -= 1
      end
      decrease_sell_in_value(item)
      if item.sell_in < 0 and item.quality > 0
        item.quality -= 1
      end
    end
  end

  def increase_items_quality(increasing_quality_items)
    increasing_quality_items.each do |item|
      if item.quality < 50
      item.quality += 1
        if item.name.eql?("Backstage passes to a TAFKAL80ETC concert")
          if item.sell_in <= 10
            if item.quality < 50
              item.quality +=1
            end
          end
          if item.sell_in <= 5 and item.quality < 50
            item.quality += 1
          end
        end
        decrease_sell_in_value(item)
        if item.sell_in < 0
          if item.name.eql?("Aged Brie")
            item.quality += 1
          else
            item.quality = 0 
          end
        end 
      end
    end
  end

  def decrease_conjured_items_quality(conjured_items)
    conjured_items.each do |item|
      if item.quality > 0
        item.quality -= 2
      end
      decrease_sell_in_value(item)
      if item.sell_in < 0
        item.quality -= 2
      end
    end
  end

  def decrease_sell_in_value(item)
    item.sell_in -= 1
  end
end