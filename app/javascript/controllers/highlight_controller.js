import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.remove("highlight");
    }, 3000); // Remove highlight after 1 second
  }
}