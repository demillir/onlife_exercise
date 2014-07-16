require 'test_helper'
require 'tempfile'
require 'json'
require 'rexml/document'

describe "invocation" do
  it "should exit with a non-error status" do
    assert system('bin/onlife > /dev/null')
  end

  it "should display results on the terminal" do
    `bin/onlife`.must_match /crown winner/i
  end

  describe "with an output file name" do
    let(:outfile) { Tempfile.new('invocation_test') }

    it "should write to the output file" do
      begin
        system("bin/onlife --outfile=#{outfile.path}")
        outfile.close
        IO.read(outfile.path).must_match /crown winner/i
      ensure
        outfile.unlink
      end
    end
  end

  describe "with JSON formatted output" do
    let(:output)  { `bin/onlife --format=json` }
    let(:results) { JSON.parse(output) }

    it "should produce valid JSON" do
      results.must_be_kind_of Hash
      results.keys.must_include 'triple_crown_winners'
    end
  end

  describe "with XML formatted output" do
    let(:output)  { `bin/onlife --format=xml` }
    let(:results) { REXML::Document.new(output) }

    it "should produce valid XML" do
      results.must_be_kind_of REXML::Document
      results.root.elements['triple-crown-winners'].must_be_kind_of REXML::Element
    end
  end
end
