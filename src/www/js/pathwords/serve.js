let playerCount;
let playersExpected;
let playersNeeded;
let playersJoining;
let playerList;

document.addEventListener("DOMContentLoaded", function(event) {
    playerCount = document.querySelector("#player-count");
    playersExpected = document.querySelector("#players-expected");
    playersNeeded = document.querySelector("#players-needed");
    playersJoining = document.querySelector("#players-joining");
    playerList = document.querySelector("#players");

    getUpdate();
});

function getUpdate() {
    setTimeout(() => {
        fetch("/pathwords/server_pulse")
            .then(response => response.json())
            .then(displayUpdate);
    }, 444);
}

function displayUpdate(response) {
    if (response.playersExpected > 0) {
        playersNeeded.style.display = "none";
        playersJoining.style.display = "block";
        playerCount.innerText = response.playerCount;
        playersExpected.innerText = response.playersExpected;
    } else {
        playersNeeded.style.display = "block";
        playersJoining.style.display = "none";
    }

    players.replaceChildren();
    response.players.forEach((player) => {
        const li = document.createElement("li")
        li.innerText = player
        players.appendChild(li);
    });

    getUpdate();
}