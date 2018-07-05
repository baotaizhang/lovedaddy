class MessageDecorator < Draper::Decorator
  decorates_association :to_user,   with: UserDecorator
  decorates_association :from_user, with: UserDecorator
  delegate_all

  def post_date_tag
    h.content_tag(:time, class: 'msgDate') do
      post_date
    end
  end

  def post_datetime
    post_date + post_time
  end

  def post_date
    time = model.created_at
    time.strftime("%m月%d日（#{%w(日 月 火 水 木 金 土)[time.wday]}）")
  end

  def post_time
    model.created_at.strftime('%H:%M')
  end
end
