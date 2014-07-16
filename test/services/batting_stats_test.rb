require 'test_helper'
require 'services/batting_stats'

describe BattingStats do
  subject { BattingStats.new }

  describe "#most_improved_avg" do
    let(:result) { subject.most_improved_avg(year: 2012) }

    it "should return a player hash" do
      result.must_be_kind_of Hash
      result.keys.must_include :player_id
    end
  end

  describe "#slugging_percentages" do
    let(:result) { subject.slugging_percentages(year: 2012) }

    it "should return an array of player hashes" do
      result.must_be_kind_of Array
      result.map(&:class).uniq.must_equal [Hash]
      result.first.keys.must_include :player_id
    end

    describe "with a team filter" do
      let(:result) { subject.slugging_percentages(year: 2012, team: 'OAK') }

      it "should only return players who were on the given team" do
        result.map { |plyr| plyr[:team_id] }.uniq.must_equal ['OAK']
      end
    end
  end
end
