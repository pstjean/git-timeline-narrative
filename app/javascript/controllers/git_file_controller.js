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

  connect() {
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

            line.addEventListener("mouseup", (e) => {
              this.lineTargets.forEach((line) =>
                line.removeEventListener("mouseenter", this.lineMousedOver)
              );

              const end = e.target.closest('[data-git-file-target="line"]');
              end.style.backgroundColor = "purple";
            });
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
