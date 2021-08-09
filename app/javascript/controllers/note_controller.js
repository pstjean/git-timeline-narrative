import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [];
  static values = {};

  connect() {
    this.element.append("This is a note")
  }

  save() {
    this.element.append("Saved")
  }
}
