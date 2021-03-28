let lastButton = "";
let buttons;
let playerCount;
let playersExpected;
let stageZero;
let stageOne;
let stageTwo;
let stageThree;
let startsIn;
let timeLeft;
let wordList;

document.addEventListener("DOMContentLoaded", function (event) {
  getUpdate();

  let buttons = document.querySelectorAll(".unscramble .board .die");
  buttons.forEach((button) => {
    button.addEventListener("click", dieClicked, false);
  });

  playerCount = document.querySelector("#player-count");
  playersExpected = document.querySelector("#players-expected");
  stageZero = document.querySelectorAll(".stage-0");
  stageOne = document.querySelectorAll(".stage-1");
  stageTwo = document.querySelectorAll(".stage-2");
  stageThree = document.querySelectorAll(".stage-3");
  startsIn = document.querySelector("#starts-in");
  timeLeft = document.querySelector("#time-left");
  wordList = document.querySelector("textarea");
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


function dieClicked() {
  if (lastButton === this.id) {
    wordList.value = wordList.value + "\n";
    lastButton = "";
  } else {
    if (areAdjacent(lastButton, this.id)) {
      lastButton = this.id;
      wordList.value = wordList.value.concat(this.innerText);
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
    show(stageZero);
    hide(stageOne);
    hide(stageTwo);
    hide(stageThree);

    if (response.playersExpected > 0) {
      playerCount.innerText = response.playerCount;
      playersExpected.innerText = response.playersExpected
    }
  }
  else if (response.stage == 1) {
    hide(stageZero);
    show(stageOne);
    hide(stageTwo);
    hide(stageThree);
    startsIn.innerText = response.timer;
  }
  else if(response.stage == 2) {
    hide(stageZero);
    hide(stageOne);
    show(stageTwo);
    hide(stageThree);
    timeLeft.innerText = response.timer;
  }
  else if(response.stage == 3) {
    hide(stageZero);
    hide(stageOne);
    hide(stageTwo);
    show(stageThree);
    timeLeft.innerText = response.timer;
  }

  getUpdate();
}