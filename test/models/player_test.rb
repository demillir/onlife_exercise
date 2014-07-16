require 'test_helper'
require 'models/player'

describe Player do
  describe ".find_by_id!" do
    let(:result) { Player.find_by_id!('aaronha01') }

    it "should return a Player object" do
      result.must_be_kind_of Player
    end

    describe "with an ID that cannot be found" do
      let(:result) { Player.find_by_id!('unknown') }

      it "should raise an exception" do
        proc { result.wont_be_kind_of Player }.must_raise RuntimeError
      end
    end
  end
end
