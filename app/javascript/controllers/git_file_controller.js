import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["line"];
  static values = { nexus: Number, nexusLoc: Object, lineIds: Array, gitNoteId: Number, fileId: Number };

  lineDomElement(id) {
    return document.querySelector(`[data-line-id="${id}"]`);
  }

  lineMousedOver(e) {
    const lineEl = e.target.closest('[data-git-file-target="line"]')
    lineEl.style.backgroundColor = "yellow";
    this.lineIdsValue = this.lineIdsValue.concat([lineEl.dataset.lineId])
  }

  lineMousedUp(e) {
    console.log(this.lineIdsValue);
    this.lineTargets.forEach((line) => {
      line.removeEventListener("mouseenter", this.lineMousedOver);
      line.removeEventListener("mouseup", this.lineMousedUp);
    });

    const end = e.target.closest('[data-git-file-target="line"]');
    end.style.backgroundColor = "orange";
    this.insertNoteEditor(end);
  }

  insertNoteEditor(line) {
    // <turbo-frame id="git_note_file_note" src="/git_notes/<%= @git_note.id %>/file_notes/new?<%= file_line_ids_param %>file_id=1">
    const editor = document.createElement("turbo-frame")
    editor.setAttribute("src", `/git_notes/${this.gitNoteIdValue}/file_notes/new?${this.lineIdsValue.map(id => `line_ids[]=${id}`).join('&')}&file_id=${this.fileIdValue}`)
    editor.id = "git_note_file_note"

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
          this.lineIdsValue = [this.nexusIdValue] // Reset line IDs to begin new range
          this.lineDomElement(this.nexusIdValue).style.backgroundColor = "orange";

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
