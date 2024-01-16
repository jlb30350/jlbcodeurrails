$(document).ready(function() {
    $(".navbar a, footer a").on("click", function(event) {
      event.preventDefault();
      var hash = this.hash;
  
      $("body").animate({ scrollTop: $(hash).offset().top }, 900, function() {
        window.location.hash = hash;
      });
    });
  
    $("#contact-form").submit(function(e) {
      e.preventDefault();
      $(".comments").empty();
      var postdata = $("#contact-form").serialize();
      console.log(postdata);
      $.ajax({
        type: "POST",
        url: "/submit",
        data: postdata,
        dataType: "json",
        success: function(result) {
          if (result.isSuccess) {
            $("#contact-form").append(
              "<p class='thank-you'>Votre message a bien été envoyé. Merci de m'avoir contacté :)</p>"
            );
            $("#contact-form")[0].reset();
          } else {
            if (result.firstnameError) {
              $("#firstname + .comments").html(result.firstnameError);
            }
            if (result.nameError) {
              $("#name + .comments").html(result.nameError);
            }
            if (result.emailError) {
              $("#email + .comments").html(result.emailError);
            }
            if (result.phoneError) {
              $("#phone + .comments").html(result.phoneError);
            }
            if (result.messageError) {
              $("#message + .comments").html(result.messageError);
            }
          }
        },
      });
    });
  });
  