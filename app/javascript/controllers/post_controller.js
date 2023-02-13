import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {

  static targets = ["title", "content", "submitBtn","removeBtn"];

  remove(){
    this.removeBtnTarget.click()
  }

  submit(){
    this.submitBtnTarget.click()
  }
}
