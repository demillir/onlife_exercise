require 'test_helper'
require 'parsers/batting_loader'

describe BattingLoader do
  describe ".load_csv" do
    describe "with a non-existent input file" do
      it "should raise an exception" do
        proc { BattingLoader.load_csv('dunna_exist') }.must_raise Errno::ENOENT
      end
    end

    describe "with a badly-formatted input file" do
      it "should raise an exception" do
        fixture_dir = File.expand_path("../../fixtures", Pathname.new(__FILE__).realpath)
        proc { BattingLoader.load_csv(File.join(fixture_dir, 'bad.csv')) }.must_raise RuntimeError
      end
    end
  end
end
