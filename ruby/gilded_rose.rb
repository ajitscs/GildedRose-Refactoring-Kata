class GildedRose

  def initialize(items)
    @items = items
    @method_mapping = {
      '+5 Dexterity Vest' => 'dexterity',
      'Aged Brie' => 'aged_brie',
      'Elixir of the Mongoose' => 'elixir',
      'Sulfuras, Hand of Ragnaros' => 'sulfuras',
      'Backstage passes to a TAFKAL80ETC concert' => 'backstage',
      'Conjured Mana Cake' => 'conjured'
    }.freeze
  end
  attr_accessor :method_mapping

  def update_quality()
    @items.map { send("process_#{method_mapping[_1.name]}", _1) && update_sell_in(_1) }
  end

  def process_dexterity(item)
    item.quality -= 1
  end

  def process_backstage(item)
    return item.quality = 0 if item.sell_in <= 0
    return update_quality_with(2, item) if item.sell_in > 5 && item.sell_in <= 10
    return update_quality_with(3, item) if item.sell_in <= 5 && item.sell_in >= 0
    update_quality_with(1, item)
  end

  def update_quality_with(count, item)
    count.times { item.quality += 1 unless item.quality == 50 }
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def process_aged_brie(item)
    return if item.quality >= 50
    return item.quality += 2 if item.sell_in <= 0
    item.quality += 1
  end

  def process_elixir(item)
    process_common(item)
  end

  def process_sulfuras(item)
    return
  end

  def process_conjured(item)
    process_common(item)
  end

  def process_common(item)
    return item.quality if item.quality.zero?
    return item.quality = 0 if item.sell_in <= 0
    item.quality -= 1
  end

  # def update_quality()
  #   @items.each do |item|
  #     if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
  #       if item.quality > 0
  #         if item.name != "Sulfuras, Hand of Ragnaros"
  #           item.quality = item.quality - 1
  #         end
  #       end
  #     else
  #       if item.quality < 50
  #         item.quality = item.quality + 1
  #         if item.name == "Backstage passes to a TAFKAL80ETC concert"
  #           if item.sell_in < 11
  #             if item.quality < 50
  #               item.quality = item.quality + 1
  #             end
  #           end
  #           if item.sell_in < 6
  #             if item.quality < 50
  #               item.quality = item.quality + 1
  #             end
  #           end
  #         end
  #       end
  #     end
  #     if item.name != "Sulfuras, Hand of Ragnaros"
  #       item.sell_in = item.sell_in - 1
  #     end
  #     if item.sell_in < 0
  #       if item.name != "Aged Brie"
  #         if item.name != "Backstage passes to a TAFKAL80ETC concert"
  #           if item.quality > 0
  #             if item.name != "Sulfuras, Hand of Ragnaros"
  #               item.quality = item.quality - 1
  #             end
  #           end
  #         else
  #           item.quality = item.quality - item.quality
  #         end
  #       else
  #         if item.quality < 50
  #           item.quality = item.quality + 1
  #         end
  #       end
  #     end
  #   end
  # end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
