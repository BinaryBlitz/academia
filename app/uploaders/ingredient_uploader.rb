class IngredientUploader < ApplicationUploader
  # Process files as they are uploaded:
  process resize_to_limit: [150, 150]
  process convert: 'jpg'
  process quality: 85
end
