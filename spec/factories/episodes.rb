FactoryGirl.define do
  factory :episode do
    tv_show
    user
    name 'TV Show 1'
    air_date '2016-02-14 16:47:51'
    season 1
    episode_number 1
  end
end
