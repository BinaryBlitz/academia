class DishUploader < ApplicationUploader
  # Process files as they are uploaded:
  process resize_to_limit: [720, 1280]
  process convert: 'jpg'
  process quality: 90
end
