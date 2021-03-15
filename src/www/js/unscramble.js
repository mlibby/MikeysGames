let lastButton = "";

let buttons = document.querySelectorAll(".unscramble .board .die");
buttons.forEach((button) => {
  button.addEventListener("click", dieClicked, false);
});

function areAdjacent(a, b) {
  if (a === "" || b === "") {
    return true;
  }

  let cell, ax, ay, bx, by;
  [cell, ax, ay] = a.split("-");
  [cell, bx, by] = b.split("-");

  if (ax === bx) {
    return Math.abs(ay - by) === 1;
  }
  else if (ay === by) {
    return Math.abs(ax - bx) === 1;
  }
  else {
    return false;
  }
}

let wordList = document.querySelector("textarea");
function dieClicked() {
  if (lastButton === this.id) {
    wordList.value = wordList.value + "\n";
    lastButton = "";
  }
  else {
    if (areAdjacent(lastButton, this.id)) {
      lastButton = this.id;
      wordList.value = wordList.value.concat(this.innerText);
    }
  }
}
