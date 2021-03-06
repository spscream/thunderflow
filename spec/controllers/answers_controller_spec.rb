require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:question) { create(:question) }

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves answer to database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(Answer, :count).by(1)
      end
      it 'renders create template' do
        post :create, question_id: question.id, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end
    context 'with invalid attributes' do
      it 'does not save question' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
      end
      it 'renders answers/create template' do
        post :create, question_id: question.id, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'POST #accept' do
    sign_in_user

    context 'user is author of question' do
      let(:question) { create(:question, user: user) }
      let(:answer1) { create(:answer, question: question, user: user) }
      let(:answer2) { create(:answer, question: question, user: user) }

      context 'question has no accepted answers' do
        it 'marks an answer as accepted' do
          expect { post :accept, id: answer1, format: :js }.to change(Answer.accepted, :count).by(1)
        end
      end

      context 'question has accepted answers' do
        before do
          answer1.accept
          post :accept, id: answer2, format: :js
        end

        it "returns error message 'Question already has accepted answer.'" do
          expect(response.body).to eq 'Question already has accepted answer.'
        end
        it { is_expected.to respond_with 403 }
      end
    end

    context 'user is not an author of question' do
      let(:user1) { create(:user) }
      let(:answer) { create(:answer, user: user1) }

      it 'should raise ActiveRecord::RecordNotFound exception' do
        expect {post :accept, id: answer.id, format: :js}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let(:answer) { create(:answer, question: question, user: user) }

    it 'assings the requested answer to @answer' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'changes answer attributes' do
      patch :update, id: answer, question_id: question, answer: {text: 'new body'}, format: :js
      answer.reload
      expect(answer.text).to eq 'new body'
    end

    it 'renders update template' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer) { create(:answer, question: question, user: user)}


    it 'deletes the requested answer' do
      expect{delete :destroy, id: answer, format: :js}.to change(Answer, :count).by(-1)
    end
    it 'renders destroy template' do
      delete :destroy, id: answer, format: :js
      should render_template :destroy
    end
  end
end
