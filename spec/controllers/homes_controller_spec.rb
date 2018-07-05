require 'rails_helper'

RSpec.describe HomesController, type: :controller do

  describe "GET #top" do
    it "returns http success" do
      get :top
      expect(response).to be_successful
    end
  end

end
