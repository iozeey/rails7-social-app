import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  static targets = ["submitBtn","removeBtn", "replyBtn", "replyBox"];

  toggleReplyBox(e){
    const replyBoxId = e.params["form"]
    const form = document.getElementById(replyBoxId)
    form.classList.toggle("hidden");
  }

  remove(){
    this.removeBtnTarget.click()
  }

  submit(){
    this.submitBtnTarget.click()
  }
}
