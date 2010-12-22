File.open("./posts.json", "w") do |f|
  Post.find_each do |post|
    hash = { 'title' => post.title, 'body' => post.body,
      'created_at' => post.created_at, 'updated_at' => post.updated_at }
    hash['tag_list'] = post.tag_list
    f.write(hash.to_json + "\n\n")
  end
end
