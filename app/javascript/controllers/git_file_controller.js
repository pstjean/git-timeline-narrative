import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["line"];
  static values = { nexus: Number, nexusLoc: Object };

  lineDomElement(id) {
    return document.querySelector(`[data-line-id="${id}"]`);
  }

  lineMousedOver(e) {
    e.target.closest('[data-git-file-target="line"]').style.backgroundColor =
      "yellow";
  }

  lineMousedUp(e) {
    console.log(this.lineTargets);
    this.lineTargets.forEach((line) => {
      line.removeEventListener("mouseenter", this.lineMousedOver);
      line.removeEventListener("mouseup", this.lineMousedUp);
    });

    const end = e.target.closest('[data-git-file-target="line"]');
    end.style.backgroundColor = "purple";
    this.insertNoteEditor(end);
  }

  insertNoteEditor(line) {
    // We'd want to insert an element with its own stimulus controller
    const editor = document.createElement("div")
    editor.setAttribute("data-controller", "note");

    const edButton = document.createElement("button")
    edButton.innerText = "Save"
    edButton.setAttribute("data-action", "click->note#save")

    const edInput = document.createElement("textarea");

    editor.append(edInput, edButton)
    console.log(editor)

    //[edInput, edButton].forEach(el => editor.appendChild(el))
    line.insertAdjacentElement("afterend", editor);
  }

  connect() {
    this.lineMousedOver = this.lineMousedOver.bind(this);
    this.lineMousedUp = this.lineMousedUp.bind(this);
    const mouseEnterHandlers = [];

    this.lineTargets.forEach((line) => {
      line.addEventListener(
        "mousedown",
        (e) => {
          this.nexusIdValue = e.target.closest(
            '[data-git-file-target="line"]'
          ).dataset.lineId;
          this.lineDomElement(this.nexusIdValue).style.backgroundColor = "blue";

          // bottom, height, left, right, top, width, x, y
          this.nexusLocValue = this.lineDomElement(
            this.nexusIdValue
          ).getBoundingClientRect();

          this.lineTargets.forEach((line) => {
            line.addEventListener("mouseenter", this.lineMousedOver, {
              once: true,
            });
            line.addEventListener("mouseup", this.lineMousedUp, { once: true });
          });
        },
        { once: true }
      );
    });
  }

  nexusLocValueChanged() {
    console.log(this.nexusLocValue);
  }
}
