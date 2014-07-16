require 'test_helper'
require 'parsers/player_loader'

describe PlayerLoader do
  describe ".load_csv" do
    describe "with a non-existent input file" do
      it "should raise an exception" do
        proc { PlayerLoader.load_csv('dunna_exist') }.must_raise Errno::ENOENT
      end
    end

    describe "with a badly-formatted input file" do
      it "should raise an exception" do
        fixture_dir = File.expand_path("../../fixtures", Pathname.new(__FILE__).realpath)
        proc { PlayerLoader.load_csv(File.join(fixture_dir, 'bad.csv')) }.must_raise RuntimeError
      end
    end
  end
end
