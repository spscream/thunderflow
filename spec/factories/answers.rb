# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    question
    text 'This is the awesome answer on your question. Very helpfull!'
    is_accepted false
  end

  factory :invalid_answer, class: "Answer" do
    question
    text nil
    is_accepted false
  end
end
