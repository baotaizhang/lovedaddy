require 'rails_helper'

RSpec.describe BoardPostDecorator do
  describe "#formated_created_at" do
    let(:user) {create(:user)}
    let(:board_post) {create(:board_post, user: user, created_at: Time.zone.parse('2018-02-02 10:15:50'))}

    it "正しいフォーマットで表示されること" do
      expect(board_post.decorate.formated_created_at).to eq "02/02 10:15"
    end
  end
end
