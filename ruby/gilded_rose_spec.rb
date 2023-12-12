require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  context "#update_quality" do
    it "does not change the name" do
      items = [Item.new("Aged Brie", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Aged Brie"
    end

    let(:vest) { Item.new('+5 Dexterity Vest', 10, 20) }
    let(:brie) { Item.new('Aged Brie', 2, 0) }
    let(:elixir) { Item.new('Elixir of the Mongoose', 5, 7) }
    let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 80) }
    let(:backstage) { Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20) }
    let(:conjured) { Item.new('Conjured Mana Cake', 3, 6) }

    let(:items) { [vest, brie, elixir, sulfuras, backstage, conjured] }
    let(:gilded_rose) { GildedRose.new(items) }

    it 'updates the quality of items correctly' do
      gilded_rose.update_quality
      expect(vest.quality).to eq(19)
      expect(brie.quality).to eq(1)
      expect(elixir.quality).to eq(6)
      expect(sulfuras.quality).to eq(80)
      expect(backstage.quality).to eq(21)
      expect(conjured.quality).to eq(5)
    end

    it 'updates the sell_in of items correctly' do
      gilded_rose.update_quality
      expect(vest.sell_in).to eq(9)
      expect(brie.sell_in).to eq(1)
      expect(elixir.sell_in).to eq(4)
      expect(sulfuras.sell_in).to eq(0)
      expect(backstage.sell_in).to eq(14)
      expect(conjured.sell_in).to eq(2)
    end
  end
end
