require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:question) { create(:question) }
  describe 'POST #create' do
    sign_in_user
    context "with valid attributes" do
      it "saves answer to database" do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(Answer, :count).by(1)
      end
      it "render create template" do
        post :create, question_id: question.id, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end
    context "with invalid attributes" do
      it "does not save question" do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
      end
      it "re-renders question show view" do
        post :create, question_id: question.id, answer: attributes_for(:invalid_answer), format: :js
        should render_template "questions/show"
      end
    end
  end

  describe 'POST #accept' do
    sign_in_user
    context "user is author of question" do
      context "question has no accepted questions" do
        let!(:answer) { create(:answer, user: user, accepted: false) }
        it "marks an answer as accepted" do
          expect{post :accept, id: answer.id, format: :js}.to change(Answer.accepted, :count).by(1)
        end
        it "renders accept view" do
          post :accept, id: answer.id, format: :js
          should render_template :accept
        end
      end
      context "question has accepted question" do
        let!(:question) { create(:question, user: user)}
        let!(:answer1) { create(:answer, question: question, accepted: true)}
        let!(:answer2) { create(:answer, question: question, accepted: false)}
        before {
          post :accept, id: answer2.id, format: :js
        }
        it { should respond_with(403)}
      end
    end

    context "user is not an author of question" do
      let(:user1) {create(:user)}
      let(:answer) {create(:answer, user: user1)}
      before {
        post :accept, id: answer.id, format: :js
      }
      it { should respond_with(403)}
    end
  end
end
