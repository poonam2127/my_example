FactoryBot.define do
  factory :question do
    title { 'What is the meaning of life?' }
    body { 'I need legal advice on the purpose of life.' }
    category { 'Philosophy' }
    association :user  # This associates the question with a user
  end
end