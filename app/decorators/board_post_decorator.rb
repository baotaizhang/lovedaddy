class BoardPostDecorator < Draper::Decorator
  decorates_association :user
  delegate_all

  def formated_created_at
    object.created_at.strftime("%m/%d %H:%M")
  end
end
