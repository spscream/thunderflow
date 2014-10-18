require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  let (:question) { create(:question) }
  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    it { should render_template :index }
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it { should render_template :show }
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }

    it 'assigns new Question in @question' do
      expect(assigns[:question]).to be_a_new(Question)
    end

    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it { should render_template :new }
  end

  describe 'GET #edit' do
    sign_in_user
    let(:question) { create(:question, user: user)}
    context 'User is owner of question' do
      before { get :edit, id: question }

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it { should render_template :edit }
    end

    context 'User is not an owner of question' do
      let(:question) {create(:question)}
      before { get :edit, id: question}

      it { should redirect_to question_path(question) }
      it 'sets flash error message' do
        expect(flash[:error]).to have_content 'You cannot edit question. You are not an owner.'
      end
    end

  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect{ post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect{ post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        should render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    context 'valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, id: question, question: { title: 'new title', text: 'new text updated with update method'}
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.text).to eq 'new text updated with update method'
      end

      it 'redirects to the updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: question, question: { title: 'new title', text: nil} }
      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq 'How to write a tests?'
        expect(question.text).to eq 'I\'m writing tests for thunderflow, how to do it right?'
      end

      it 're-renders edit view' do
        should render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    it 'deletes the requested question' do
      question
      expect{delete :destroy, id: question, format: :js}.to change(Question, :count).by(-1)
    end
    it 'renders destroy template' do
      delete :destroy, id: question, format: :js
      should render_template :destroy
    end
  end
end
