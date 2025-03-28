import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    setTimeout(() => this.dismiss(), 3000); // 3 sec delay
  }

  dismiss() {
    this.element.style.transition = "opacity 0.5s";
    this.element.style.opacity = "0";
    setTimeout(() => this.element.remove(), 500);
  }
}
