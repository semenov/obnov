module ApplicationHelper
  def gravatar_for user, options = {}
    options = {:alt => user.email, :class => 'avatar', :size => 20}.merge! options
    id = Digest::MD5::hexdigest user.email.strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '.jpg?d=retro&s=' + options[:size].to_s
    options.delete :size
    image_tag url, options
  end
end
