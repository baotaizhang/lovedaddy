class UserDecorator < Draper::Decorator
  decorates_association :board_posts
  decorates_association :receive_messages, with: MessageDecorator
  decorates_association :send_messages,    with: MessageDecorator
  delegate_all

  def no_image_url
    # TODO: 男女などでデフォルト画像を分ける？
    h.image_url('common/nophoto.png')
  end

  def display_main_image_url(size = :origin)
    return no_image_url unless object.main_profile_image?

    case size.to_sym
    when :origin
      object.main_profile_image.url
    when :thumb
      object.main_profile_image.thumb.url
    else
      raise ArgumentError
    end
  end

  def age
    return nil if object.birthday.blank?
    now = Time.current.strftime("%Y%m%d").to_i
    birthday = object.birthday.strftime("%Y%m%d").to_i
    (now - birthday) / 10000
  end

  def last_login_status
    if object.has_option?(:hide_online)
      "最終ログイン#{h.time_ago_in_words(Settings.options.hide_online.display_past_days.days.ago)}前"
    elsif online?
      'オンライン'
    else
      "最終ログイン#{h.time_ago_in_words(object.last_logged_in_at)}前"
    end
  end

  private

    def online?
      (Time.current - object.last_logged_in_at) < Settings.online_sec
    end
end
