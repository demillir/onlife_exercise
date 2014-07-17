require 'test_helper'
require 'models/batting'

describe Batting do
  describe ".find_by" do
    let(:result) { Batting.find_by(year: 2010) }

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

  describe "#slugging_percentage" do
    it "returns a float" do
      Batting.new(player_id: 'xxx').slugging_percentage.must_be_kind_of Float
      Batting.new(player_id: 'xxx', hits: 10, at_bats: 20).slugging_percentage.must_be_kind_of Float
    end

    it "returns the correct value" do
      Batting.new(player_id: 'xxx', hits: 10, doubles: 2, triples: 3, home_runs: 4, at_bats: 20).slugging_percentage.must_equal 150.0
    end

    describe "with no at-bats" do
      it "returns zero" do
        Batting.new(player_id: 'xxx').slugging_percentage.must_equal 0.0
        Batting.new(player_id: 'xxx', hits: 10, at_bats: 0).slugging_percentage.must_equal 0.0
      end
    end
  end
end
