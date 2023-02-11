import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["name"]

  greet() {
    console.log("Hello, Stimulus!", this.name)
  }

  get name() {
    return this.nameTarget.value
  }
}
