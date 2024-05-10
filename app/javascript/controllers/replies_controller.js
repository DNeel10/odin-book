import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="replies"
export default class extends Controller {
  static targets = [ "button", "form" ]
  static classes = [ "primary" ]
  
  toggle(e) {
    e.preventDefault
    this.formTarget.classList.toggle("d-none")
  }

}
