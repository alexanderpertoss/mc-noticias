import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validation"
export default class extends Controller {
  static targets = ["title", "author", "language", "videoUrl", "visits", "category", "submit", "titleError", "authorError", "languageError", "videoUrlError", "visitsError", "categoryError"];

  validateTitle() {
    if (this.titleTarget.value.length < 5) {
      this.successMessageTarget.textContent = "";
      this.titleErrorTarget.textContent = "El título debe tener al menos 5 caracteres";
    } else {
      this.titleErrorTarget.textContent = "";
      this.successMessageTarget.textContent = "Título válido";
    }
  }

  validateContent() {
    if (this.contentTarget.value.trim() === "") {
      this.contentTarget.setCustomValidity("El contenido no puede ir vacío");
    } else {
      this.contentTarget.setCustomValidity("");
    }
  }
}
