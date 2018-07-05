FactoryBot.define do
  factory :user do
    password "password"
    sequence(:email) { |n| "dummy#{n}@example.com" }
    sequence(:nickname) { |n| "ニックネーム#{n}" }
    sequence(:birthday) { |n| (n + 20).years.ago.to_date }
    sequence(:last_logged_in_at ) { |n| n.hours.ago }

    sequence(:residence_id ) { |n| n % 47 + 1}
    sequence(:birthplace_id ) { |n| n % 47 + 1}
    sequence(:sex) { |n| n % 2 + 1 }
    sequence(:marital_relationship ) { |n| n % 2 + 1 }
    sequence(:motivation) { |n| n % 5 + 1 }
    sequence(:body_shape) { |n| n % 3 + 1 }
    sequence(:drinking) { |n| n % 3 + 1 }
    sequence(:smoking) { |n| n % 3 + 1 }
    sequence(:occupation) { |n| n % 8 + 1 }
    height   User::RANGE_HEIGHT.sample
    income   User::RANGE_INCOME.sample
    property User::RANGE_PROPERTY.sample

    after(:create) do |user|
      user.activate!
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)      default(""), not null
#  crypted_password                :string(255)      default(""), not null
#  salt                            :string(255)      default(""), not null
#  url_token                       :string(255)      not null
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  activation_state                :string(255)
#  activation_token                :string(255)
#  activation_token_expires_at     :datetime
#  sex                             :integer
#  nickname                        :string(255)
#  birthday                        :date
#  birthplace_id                   :integer
#  residence_id                    :integer
#  height                          :integer
#  body_shape                      :integer
#  drinking                        :integer
#  smoking                         :integer
#  marital_relationship            :integer
#  motivation                      :integer
#  occupation                      :integer
#  income                          :integer
#  property                        :integer
#  role                            :integer          default("general")
#  introduction                    :text(65535)
#  last_logged_in_at               :datetime
#  main_profile_image              :string(255)
#  deleted_at                      :datetime
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  failed_logins_count             :integer          default(0)
#  lock_expires_at                 :datetime
#  unlock_token                    :string(255)
#
