class BadgeUploader < ApplicationUploader
  # Process files as they are uploaded:
  process resize_to_limit: [100, 100]
  process convert: 'png'
end
