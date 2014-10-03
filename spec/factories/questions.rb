# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "How to write a tests?"
    text "I'm writing tests for thunderflow, how to do it right?"
    user
    factory :question_with_answers do
      ignore do
        answers_count 5
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question, user: question.user)
      end
    end
  end

  factory :invalid_question, class: "Question" do
    user
    title nil
    text nil
  end
end
