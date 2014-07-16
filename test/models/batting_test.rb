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
end
