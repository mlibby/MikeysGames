let dice;
let boardLoaded = false;
let lastButton = "";
let playerCount;
let playersExpected;
let stageZero;
let stageOne;
let stageTwo;
let stageThree;
let startsIn;
let timeLeft;
let wordInProgress;
let wordsPlayed;

document.addEventListener("DOMContentLoaded", function (event) {
  getUpdate();

  dice = document.querySelectorAll(".die");
  playerCount = document.querySelector("#player-count");
  playersExpected = document.querySelector("#players-expected");
  stageZero = document.querySelectorAll(".stage-0");
  stageOne = document.querySelectorAll(".stage-1");
  stageTwo = document.querySelectorAll(".stage-2");
  stageThree = document.querySelectorAll(".stage-3");
  startsIn = document.querySelector("#starts-in");
  timeLeft = document.querySelector("#time-left");
  wordInProgress = document.querySelector("#word-in-progress");
  wordsPlayed = document.querySelector("#words-played");
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

function loadBoard(board) {
  if (!boardLoaded) {
    board.forEach((diceInRow, row) => {
      diceInRow.forEach((showing, column) => {
        const die = document.querySelector("#cell-" + row + "-" + column);
        die.innerText = showing;
        die.addEventListener("click", dieClicked, false);
      });
    });
    boardLoaded = true;
  }
}

function unloadBoard() {
  if (boardLoaded) {
    const dice = document.querySelectorAll(".die");
    dice.forEach((die) => {
      die.removeEventListener("click", dieClicked);
    });
    boardLoaded = false;
  }
}

function dieClicked() {
  if (lastButton === this.id) {
    const li = document.createElement("li");
    li.innerText = wordInProgress.value;
    wordsPlayed.appendChild(li);
    wordInProgress.value = "";
    lastButton = "";
  }
  else {
    if (areAdjacent(lastButton, this.id)) {
      lastButton = this.id;
      wordInProgress.value = wordInProgress.value.concat(this.innerText);
    }
  }
}

function getUpdate() {
  setTimeout(() => {
    fetch("/pathwords/player_pulse")
      .then(response => response.json())
      .then(displayUpdate);
  }, 444);
}

function show(nodes) {
  nodes.forEach((node) => {
    node.style.display = "block";
  })
}

function hide(nodes) {
  nodes.forEach((node) => {
    node.style.display = "none";
  })
}

function displayUpdate(response) {
  if (response.stage == 0) {
    hide(stageOne);
    hide(stageTwo);
    hide(stageThree);
    show(stageZero);

    if (response.playersExpected > 0) {
      playerCount.innerText = response.playerCount;
      playersExpected.innerText = response.playersExpected
    }
  }
  else if (response.stage == 1) {
    hide(stageZero);
    hide(stageTwo);
    hide(stageThree);
    show(stageOne);
    startsIn.innerText = response.timer;
  }
  else if (response.stage == 2) {
    hide(stageZero);
    hide(stageOne);
    hide(stageThree);
    show(stageTwo);
    loadBoard(response.board);

    timeLeft.innerText = response.timer;
  }
  else if (response.stage == 3) {
    hide(stageZero);
    hide(stageOne);
    hide(stageTwo);
    show(stageThree);
    unloadBoard();
    timeLeft.innerText = response.timer;
  }

  if(response.stage < 3) {
    getUpdate();
  }
}