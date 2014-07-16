require 'test_helper'
require 'models/batting'

describe Batting do
  describe ".gather_averages" do
    let(:result) { Batting.gather_averages(year: 2010, at_least_at_bats: 200) }

    it "should return an array of Batting objects" do
      result.must_be_kind_of Array
      result.map(&:class).uniq.must_equal [Batting]
    end
  end

  describe "#batting_avg" do
    it "returns a float" do
      Batting.new(player_id: 'xxx').batting_avg.must_be_kind_of Float
      Batting.new(player_id: 'xxx', hits: 10, at_bats: 20).batting_avg.must_be_kind_of Float
    end

    describe "with no at-bats" do
      it "returns zero" do
        Batting.new(player_id: 'xxx').batting_avg.must_equal 0.0
        Batting.new(player_id: 'xxx', hits: 10, at_bats: 0).batting_avg.must_equal 0.0
      end
    end
  end
end
