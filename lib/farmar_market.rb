# require 'csv'
# require_relative 'farmar_vendor'

module FarMar
  class Market

    attr_reader :id, :name, :address, :city, :county, :state, :zip

    def initialize(market_hash)
      @id = market_hash[:id]
      @name = market_hash[:name]
      @address = market_hash[:address]
      @city = market_hash[:city]
      @county = market_hash[:county]
      @state = market_hash[:state]
      @zip = market_hash[:zip]
    end

    def self.all
      CSV.open('./support/markets.csv', 'r').map do |line|
      self.new({id: line[0].to_i,
        name: line[1],
        address:line[2],
        city: line[3],
        county: line[4],
        state: line[5],
        zip: line[6]})
      end
    end

    def self.find(num)
      self.all.find {|market| market.id == num}
    end

    def vendors
      return FarMar::Vendor.by_market(@id)
    end

  end
end
