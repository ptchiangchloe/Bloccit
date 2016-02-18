require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let (:advertisement) { Advertisement.create! }

  describe "attribute" do
    it "should responds to title" do
      expect(advertisement).to respond_to(:title)
    end

    it "should responds to copy" do
      expect(advertisement).to respond_to(:copy)
    end

    it "should responds to price" do
      expect(advertisement).to respond_to(:price)
    end
  end
end
