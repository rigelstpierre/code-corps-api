require "rails_helper"

describe UserSkillPolicy do
  subject { described_class }

  before do
    @user = create(:user)
    @another_user = create(:user)
    @user_skill = create(:user_skill, user: @user)
  end

  permissions :index?, :show? do
    context "as a logged out user" do
      it "can view all" do
        expect(subject).to permit(nil, @user_skill)
      end
    end

    context "as the user" do
      it "can view all" do
        expect(subject).to permit(@user, @user_skill)
      end
    end

    context "as another user" do
      it "can view all" do
        expect(subject).to permit(@another_user, @user_skill)
      end
    end
  end

  permissions :create?, :destroy? do
    context "as a logged out user" do
      it "is not permitted" do
        expect(subject).to_not permit(nil, @user_skill)
      end
    end

    context "as a regular user" do
      it "is permitted" do
        expect(subject).to permit(@user, @user_skill)
      end
    end

    context "as a site admin" do
      it "is not permitted" do
        expect(subject).to_not permit(@another_user, @user_skill)
      end
    end
  end
end
