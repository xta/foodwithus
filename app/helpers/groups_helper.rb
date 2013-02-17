module GroupsHelper

  def display_top_categories(group)
    group.top_categories.map {|category| category.short_name }.to_sentence
  end

end
