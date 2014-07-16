require "test_helper"

describe "invocation" do
  it "should exit with a non-error status" do
    assert system('bin/onlife > /dev/null')
  end
end
