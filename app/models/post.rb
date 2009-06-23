class Post < ActiveRecord::Base
  validates_presence_of :body, :title

  def self.tag_finder(options)
    tag = options.delete :tag
    if(tag)
      self.tagged_with(tag, options)
    else
      self.all(options)
    end
  end

  def self.tag_counter(tag)
    if(tag)
      self.tagged_with(tag).size
    else
      self.count
    end
  end
end
