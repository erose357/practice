FactoryBot.define do
  factory :destination do
    sequence :name do |n|
      "Denver #{n}"
    end
    zip   "80215"
    description "best place ever!"
    image_url "http://media.gettyimages.com/photos/autumn-sunset-over-the-downtown-denver-skyline-picture-id166996277?s=612x612"
  end
end

