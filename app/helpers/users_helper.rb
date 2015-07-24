module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    image_tag gravatar_url_for(user), class: "usr-gravatar"
  end

  def large_gravatar_for(user)
    image_tag gravatar_url_for(user) + '?s=400',
      class: "usr-gravatar usr-gravatar_lrg"
  end

  def small_gravatar_for(user)
    image_tag gravatar_url_for(user),
      class: "usr-gravatar usr-gravatar_sml"
  end

  def gravatar_url_for(user)
    id = Digest::MD5::hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{id}"
  end
end
