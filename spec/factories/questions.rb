# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "How to write a tests?"
    text "I'm writing tests for thunderflow, how to do it right?"
  end

  factory :invalid_question, class: "Question" do
    title nil
    text nil
  end
end
