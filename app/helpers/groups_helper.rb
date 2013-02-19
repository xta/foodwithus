module GroupsHelper

  def prepopulated_group_name
    description = ["Food", "Eat", "Party", "Band", "Troop", "Grub", "Snack", "Feast", "Nuggets"].sample
    "#{description} #{Group.count}"
  end

  def display_top_categories(group)
    group.top_categories.map {|category| category.short_name }.to_sentence
  end

end
