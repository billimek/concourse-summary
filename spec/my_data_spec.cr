require "spec"
require "../src/concourse-summary/my_data"

describe "MyData" do
  describe "#label" do
    it "group is nil" do
      data = MyData.new("mypipe", nil)
      data.labels.should eq ["mypipe"]
    end
    it "group has data" do
      data = MyData.new("mypipe", "mygroup")
      data.labels.should eq ["mypipe", "mygroup"]
    end
  end

  describe "#percent" do
    it "is 0 by default" do
      data = MyData.new("", nil)
      data.percent("succeeded").should eq 0
    end

    it "is 100 if all succeeded" do
      data = MyData.new("", nil)
      data.inc("succeeded")
      data.percent("pending").should eq 0
      data.percent("succeeded").should eq 100
    end

    it "is 2/3 if all some succeeded" do
      data = MyData.new("", nil)
      data.inc("failed")
      data.inc("succeeded")
      data.inc("succeeded")
      data.percent("failed").should eq 33
      data.percent("succeeded").should eq 66
    end
  end
end
