# app/controllers/home_controller.rb
class HomeController < ApplicationController
  # Actions du contrôleur et code vont ici
  def index
    @variable = "Bonjour, monde monde !"
  end
end
