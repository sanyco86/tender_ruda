module CategoriesHelper
  def formatted_categories(categories)
    categories.map(&:name).join(', ')
  end
end
