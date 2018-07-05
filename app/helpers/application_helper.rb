module ApplicationHelper
  def show_meta_tags
    if display_meta_tags.blank?
      assign_meta_tags
    end
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    defaults = t('meta_tags.defaults')
    options.reverse_merge!(defaults)

    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url('ogp.jpg')

    configs = {
      separator: '|',
      reverse: true,
      site: site,
      title: title,
      description: description,
      keywords: keywords,
      canonical: request.original_url,
      og: {
        type: request.path == root_path ? 'website' : 'article',
        title: title.presence || site,
        description: description,
        url: request.original_url,
        image: image,
        site_name: site
      }
      #,fb: {
      #  app_id: '*****'
      #},
      #twitter: {
      #  site: '@twitter_account',
      #  card: 'summary',
      #}
    }

    set_meta_tags(configs)
  end

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :success        then 'alert-success'
    when :error, :danger then 'alert-danger'
    when :alert          then 'alert-warning'
    when :notice         then 'alert-info'
    else                      flash_type.to_s
    end
  end
end
