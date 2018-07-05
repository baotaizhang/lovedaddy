require 'rails_helper'

RSpec.describe UserDecorator do
  describe "#age" do
    context "生年月日情報がある時" do
      let(:user) {create(:user, birthday: 20.years.ago.to_date)}

      it "正しいフォーマットで表示されること" do
        expect(user.decorate.age).to eq 20
      end
    end

    context "生年月日情報がない時" do
      let(:user) {create(:user, birthday: nil)}

      it "nilを返すこと" do
        expect(user.decorate.age).to eq nil
      end
    end
  end
end
