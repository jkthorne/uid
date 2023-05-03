require "./spec_helper"

describe UID do
  it "smokes" do
    UID1.random.should_not eq(nil)
    UID2.random.should_not eq(nil)
    UID3.random.should_not eq(nil)
    UID4.random.should_not eq(nil)
  end
end
