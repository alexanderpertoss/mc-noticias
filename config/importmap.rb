# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
# Custom js for frontend
pin "easing", to: "custom/easing.js"
pin "easingmin", to: "custom/easing.min.js"
pin "owlcarousel", to: "custom/owlcarousel/owl.carousel.js"
pin "owlcarouselmin", to: "custom/owlcarousel/owl.carousel.min.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin_all_from "app/javascript/controllers", under: "controllers"
