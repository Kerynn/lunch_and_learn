require 'rails_helper'

RSpec.describe Recipe do 
  it 'exists and has attributes' do 
    recipe_data = {
      "recipe": {
        "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_1cb0bfc335666ef2f1ff31f4ba7ed4a5",
        "label": "Baked Italy",
        "image": "https://edamam-product-images.s3.amazonaws.com",
        "source": "Food52",
        "url": "https://food52.com/recipes/10380-baked-italy",
        "shareAs": "http://www.edamam.com/recipe/baked-italy-1cb0bfc335666ef2f1ff31f4ba7ed4a5/italy",
        "yield": 2.0,
        "dietLabels": [],
        "cautions": [
            "Sulfites"
        ],
        "ingredientLines": [
            "10 ounces ricotta cake, such as figgy upside down cake on this site",
            "1 cup ricotta ice cream, such as ice creamed ricotta on this site",
            "3 large egg whites, room temperature",
            "1/4 cup sugar",
            "1/4 teaspoon almond essence",
            "1/4 teaspoon salt"
        ]
      }
    }

    recipe = Recipe.new(recipe_data)

    expect(recipe).to be_an_instance_of(Recipe)
    expect(recipe.title).to eq('Baked Italy')
    expect(recipe.url).to eq('https://food52.com/recipes/10380-baked-italy')
    expect(recipe.image).to eq('https://edamam-product-images.s3.amazonaws.com')
  end
end