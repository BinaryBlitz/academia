class DishUploader < ApplicationUploader
  # Process files as they are uploaded:
  process resize_to_limit: [450, 800]
  process convert: 'jpg'
  process quality: 85
end
