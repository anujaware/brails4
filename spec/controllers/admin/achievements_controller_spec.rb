require 'spec_helper'

describe Admin::AchievementsController do
  let (:profile) { create(:profile)}
  let (:topic) { create(:full_topic)}
  let(:achievement) { build(:achievement, topic_id: topic.id)}

  before(:each) do
    login(:admin)
    profile.achievements << achievement
  end

  describe "GET #index" do
    it "populates an array of achievements" do
      get :index, user_id: profile.user_id

      page_achievements = assigns[:achievements]

      expect(page_achievements).to include(achievement)
    end

    it "renders the :index view" do
      get :index, user_id: profile.user_id

      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested achievement to @achievement" do
      get :show, user_id: profile.user_id, id: achievement.id
      page_achievement = assigns[:achievement]

      expect(achievement).to eql page_achievement
    end

    it "renders the :show view" do
      get :show, user_id: profile.user_id, id: achievement.id

      expect(response).to render_template :show
    end
  end
end