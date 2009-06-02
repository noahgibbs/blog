module PostsHelper
  PostsPerPage = 6

  def page_links(pagenum)
    num_posts = Post.count
    last_page = (num_posts + PostsPerPage - 1) / PostsPerPage

    output = ""

    output += link_to "Prev", :page => (pagenum - 1) if pagenum > 1
    output += " &nbsp; "

    if last_page <= 7
      range = (1..last_page)
    else
      range = [1, 2, 3, "...", last_page - 2, last_page - 1, last_page]
    end

    range.each do |pn|
      if(pn.kind_of? Integer)
        output += link_to pn.to_s, :page => pn
      else
        output += "..."
      end
      output += " &nbsp; "
    end
    output += link_to "Next", :page => (pagenum + 1) if pagenum < last_page

    output
  end

  def html_for_tag_list
    tags = Tag.find(:all)

    tag_html = tags.map { |tag|
      link_to(tag.name, :controller => 'posts', :action => 'index', :id => 1,
      			:tag => tag.name)
    }.join(", ")

    "<div class=\"tags\">\n  #{tag_html}\n  </div>"
  end

  def html_for_tag_div(post)
    tag_html = post.tag_list
    tags = post.tag_list.split
    tag_html = tags.map {|tn| link_to(tn, :controller=> 'posts', :action => 'index', :id => 1, :tag => tn)}.join(", ")
    "<div class=\"tags\">\n  #{tag_html}\n  </div>"
  end

end
