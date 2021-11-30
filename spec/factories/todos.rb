FactoryBot.define do
  factory :todo do
    task {'テストを書く'}
    duedate {'202106171700'}
    association :user

    trait :done do
      state { 'done' }
    end

    trait :todo do
      state { 'todo' }
    end

    trait :task_length_50 do
      task { 'ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひ' }
    end

    trait :task_length_51 do
      task { 'ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひあ' }
    end
  end
end