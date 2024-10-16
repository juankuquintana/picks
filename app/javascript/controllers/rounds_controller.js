import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleChange(event) {
    const url = event.target.value
    if (url) {
      window.location.href = url
    }
  }
}
