# app/controllers/contact_controller.rb

class ContactController < ApplicationController
  protect_from_forgery with: :null_session

  # Action pour soumettre le formulaire
  def submit
    array = build_form_data(params)
    send_email(array) if array["isSuccess"]
    render json: array
  end

  # Action pour afficher le formulaire de contact
  def contact
    # Vous pouvez initialiser le hash ici si nécessaire
  end

  private

  # Méthode privée pour vérifier le format de l'email
  def is_email(var)
    (var =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i) ? true : false
  end

  # Méthode privée pour vérifier le format du numéro de téléphone
  def is_phone(var)
    (var =~ /^[0-9 ]*$/) ? true : false
  end

  # Méthode privée pour nettoyer et vérifier les champs du formulaire
  def verify_input(var)
    var.to_s.strip
  end

  # Méthode privée pour construire les données du formulaire
  def build_form_data(params)
    array = {
      "firstname" => verify_input(params["firstname"]),
      "name" => verify_input(params["name"]),
      "email" => verify_input(params["email"]),
      "phone" => verify_input(params["phone"]),
      "message" => verify_input(params["message"]),
      "firstnameError" => "",
      "nameError" => "",
      "emailError" => "",
      "phoneError" => "",
      "messageError" => "",
      "isSuccess" => true
    }

    validate_form_data(array)
    array
  end

  # Méthode privée pour valider les données du formulaire
  def validate_form_data(array)
    validate_presence(array, "firstname", "Je veux connaitre ton prénom !")
    validate_presence(array, "name", "Et oui je veux tout savoir. Même ton nom !")
    validate_email(array, "email", "T'essaies de me rouler ? C'est pas un email ça !")
    validate_phone(array, "phone", "Que des chiffres et des espaces, stp...")
    validate_presence(array, "message", "Qu'est-ce que tu veux me dire ?")
  end

  # Méthode privée pour valider la présence d'une valeur
  def validate_presence(array, key, error_message)
    if array[key].empty?
      array["#{key}Error"] = error_message
      array["isSuccess"] = false
    end
  end

  # Méthode privée pour valider le format d'un email
  def validate_email(array, key, error_message)
    unless is_email(array[key])
      array["#{key}Error"] = error_message
      array["isSuccess"] = false
    end
  end

  # Méthode privée pour valider le format d'un numéro de téléphone
  def validate_phone(array, key, error_message)
    unless is_phone(array[key])
      array["#{key}Error"] = error_message
      array["isSuccess"] = false
    end
  end

  # Méthode privée pour envoyer l'email
  def send_email(array)
    email_to = "jeanlucbonneville@gmail.com"
    email_text = build_email_text(array)
    headers = "From: #{array['firstname']} #{array['name']} <#{array['email']}>\r\nReply-To: #{array['email']}"
    ContactMailer.send_email(email_to, "Message de jlbcodeur !!", email_text, headers).deliver_now
  end

  # Méthode privée pour construire le texte de l'email
  def build_email_text(array)
    "Firstname: #{array['firstname']}\n" \
    "Name: #{array['name']}\n" \
    "Email: #{array['email']}\n" \
    "Phone: #{array['phone']}\n" \
    "Message: #{array['message']}\n"
  end
end
