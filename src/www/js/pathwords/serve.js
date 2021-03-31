let boardLoaded = false;
let playerCount;
let playersExpected;
let playersNeeded;
let playersJoining;
let playerList;
let stageZero;
let stageOne;
let stageTwo;
let stageThree;
let startsIn;
let timeLeft;

document.addEventListener("DOMContentLoaded", function (event) {
  playerCount = document.querySelector("#player-count");
  playersExpected = document.querySelector("#players-expected");
  playersNeeded = document.querySelector("#players-needed");
  playersJoining = document.querySelector("#players-joining");
  playerList = document.querySelector("#player-list");
  stageZero = document.querySelectorAll(".stage-0");
  stageOne = document.querySelectorAll(".stage-1");
  stageTwo = document.querySelectorAll(".stage-2");
  stageThree = document.querySelectorAll(".stage-3");
  startsIn = document.querySelector("#starts-in");
  timeLeft = document.querySelector("#time-left");

  getUpdate();
});

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

function getUpdate() {
  setTimeout(() => {
    fetch("/pathwords/server_pulse")
      .then(response => response.json())
      .then(displayUpdate);
  }, 444);
}

function loadBoard(board) {
  if (!boardLoaded) {
    board.forEach((diceInRow, row) => {
      diceInRow.forEach((showing, column) => {
        const die = document.querySelector("#cell-" + row + "-" + column);
        die.innerText = showing;
      });
    });
    boardLoaded = true;
  }
}

function displayUpdate(response) {
  if (response.stage == 0) {
    hide(stageOne);
    hide(stageTwo);
    hide(stageThree);
    show(stageZero);

    if (response.playersExpected > 0) {
      playersNeeded.style.display = "none";
      playersJoining.style.display = "block";

      playerCount.innerText = response.playerCount;
      playersExpected.innerText = response.playersExpected;
    }
    else {
      playersNeeded.style.display = "block";
      playersJoining.style.display = "none";
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
    timeLeft.innerText = response.timer;
    loadBoard(response.board);
  }
  else if (response.stage == 3) {
    hide(stageZero);
    hide(stageOne);
    hide(stageTwo);
    show(stageThree);
  }

  playerList.replaceChildren();
  response.players.forEach((player) => {
    const li = document.createElement("li")
    li.innerText = player
    playerList.appendChild(li);
  });

  getUpdate();
}