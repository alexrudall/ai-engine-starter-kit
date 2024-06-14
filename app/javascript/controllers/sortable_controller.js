import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
    });
  }

  // Element dragging ended
  onEnd(event) {
    // Update the row_order_position hidden field with the new index
    event.item.querySelector(
      '[data-target="sortable.rowOrderPosition"]'
    ).value = event.newIndex;
  }
}
