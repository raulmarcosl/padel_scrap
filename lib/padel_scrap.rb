require 'padel_scrap/sports_center'

module PadelScrap
  # autoload only requires the file when the specified
  # constant is used for the first time
  autoload :GolfCanal, 'padel_scrap/sports_centers/golf_canal'
end
