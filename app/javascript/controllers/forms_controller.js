import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  resetField() {
    this.element.reset()
  }
}