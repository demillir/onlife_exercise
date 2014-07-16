require 'test_helper'
require 'services/triple_crown_stats'

describe TripleCrownStats do
  subject { TripleCrownStats.new }

  describe "#winners" do
    it "should return an array" do
      subject.winners(year: 2012).must_be_kind_of Array
    end
  end
end
