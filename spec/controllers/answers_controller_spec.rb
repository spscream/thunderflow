require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:question) { create(:question) }
  describe 'POST #create' do
    sign_in_user
    context "with valid attributes" do
      it "saves answer to database" do
        expect{ post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(Answer, :count).by(1)
      end
      it "render create template" do
        post :create, question_id: question.id, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end
    context "with invalid attributes" do
      it "does not save question" do
        expect{ post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
      end
      it "re-renders question show view" do
        post :create, question_id: question.id, answer: attributes_for(:invalid_answer), format: :js
        should render_template "questions/show"
      end
    end
  end
end
