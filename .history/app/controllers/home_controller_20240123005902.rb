# app/controllers/home_controller.rb
class HomeController < ApplicationController
  # Actions du contrôleur et code vont ici
  def index.html.erb
    @variable = "Bonjour, monde !"
  end
end
