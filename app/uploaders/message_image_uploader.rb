class MessageImageUploader < ImageUploader
  version :thumb do
    process resize_to_limit: [400, 400]
  end
end

