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

  let xdiff = Math.abs(ax - bx);
  let ydiff = Math.abs(ay - by);

  return (xdiff === 0 && ydiff === 1) ||
    (xdiff === 1 && ydiff === 0) ||
    (xdiff === 1 && ydiff === 1);
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
