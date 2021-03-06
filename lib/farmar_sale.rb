require 'csv'
require 'date'

module FarMar
  class Sale

    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

    def initialize(sale_hash)
      @id = sale_hash[:id]
      @amount = sale_hash[:amount]
      @purchase_time = sale_hash[:purchase_time]
      @vendor_id = sale_hash[:vendor_id]
      @product_id = sale_hash[:product_id]
    end

    def self.all
      CSV.open('./support/sales.csv', 'r').map do |line|
      self.new({id: line[0].to_i,
        amount: line[1].to_i,
        purchase_time: (DateTime.strptime(line[2], '%Y-%m-%d %H:%M:%S %z')),
        vendor_id: line[3].to_i,
        product_id: line[4].to_i
        })

      end
    end

    def self.between(start_time, end_time)
      self.all.each.select do |sale|
        (start_time < sale.purchase_time) && (sale.purchase_time < end_time)
      end
    end

    def self.find (num)
      self.all.find {|sale| sale.id == num}
    end

    def vendor
      FarMar::Vendor.find(@vendor_id)
    end

    def product
      FarMar::Product.find(@product_id)
    end

  end
end

# start_time = DateTime.new(2013, 11, 8, 12, 0, 0, "-8")
# end_time = DateTime.new(2013, 11, 8, 12, 59, 59, "-8")
# FarMar::Sale.between(start_time, end_time)
