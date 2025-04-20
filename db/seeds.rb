# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# ID=1
require "open-uri"

# Ensure a default image exists in your app/assets/images directory
#default_image_path = Rails.root.join("app/assets/images/ads-728x90.png")


#Category.find_or_create_by!(name: "Noticias Destacadas", description: "Las notas que saldrán en la sección de Noticias Destacadas")
# ID=2
#Category.find_or_create_by!(name: "Portada", description: "Las notas que saldrán en el carusel de la página inicial")
# ID=3
#Category.find_or_create_by!(name: "Multimedia", description: "Las notas que saldrán en la sección Multimedia")
# ID=4
#Category.find_or_create_by!(name: "Gente que hace noticia", description: "Las notas que saldrán en la sección de Gente que Hace Noticia")
# ID=5
#Category.find_or_create_by!(name: "Noticias en inglés", description: "Las notas que saldrán en la sección Inglés")
# ID=6
#Category.find_or_create_by!(name: "Noticias en quechua", description: "Las notas que saldrán en la sección Quechua")
# ID=7
#Category.find_or_create_by!(name: "Mundo interno", description: "Las notas que saldrán en la sección Mundo Interno")
# ID=8
#Category.find_or_create_by!(name: "Último momento", description: "Las notas que saldrán en la sección Mundo Interno")


#Ad.find_or_create_by!(name: "Anuncio principal")

User.create! email_address: "mccomunicacion2022@gmail.com", password: "noticiasmc9614", password_confirmation: "noticiasmc9614"
