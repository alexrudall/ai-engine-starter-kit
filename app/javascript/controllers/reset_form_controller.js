import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];

  reset() {
    this.element.reset();
    this.contentTarget.value = "";
  }
}
