module GroupsHelper

  def prepopulated_group_name
    description = %w(Scrumptious Food Edible Spicy Tasty Flavorful Delicious Great Hungry).sample
    grouping = %w(Eats Party Band Troop Feast Nuggets Outing Train Time Bites).sample
    "#{description} #{grouping}"
  end

  def display_top_categories(group)
    group.top_categories.map {|category| category.short_name }.to_sentence
  end

end
