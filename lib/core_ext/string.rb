class String
  def to_slug
    # downcase and drop space

    slug = self.downcase.strip

    #blow away apostrophes

    slug.gsub!(/['`]/, '')

    # @ --> at, and & --> and

    slug.gsub!(/\s*@\s*/, " at ")
    slug.gsub!(/\s*&\s*/, " and ")

    #replace all non alphanumeric to dash

    #slug.gsub!(/\W+/, ' ')

    slug.gsub!(/\s*[^a-z0-9]\s*/, '-')

    #Replace spaces with dashes

    slug.gsub!(' ', '-')

    #convert double dash to single

    slug.gsub!(/-+/, '-')

    #strip off leading/trailing dash

    slug.gsub!(/\A[-\.]+|[-\.]+\z/, '')

    slug
  end

end