import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('nnnnnnnnn')
    this.element.textContent = "Hello World!"
  }
}
