function getUpdate() {
    setTimeout(() => {
        fetch("/pathwords/server_pulse")
            .then(response => response.json())
            .then(displayUpdate);
    }, 444);
}

function displayUpdate(response) {
    let playerCount = document.querySelector("#player-count");
    playerCount.innerText = response.player_count;

    let players = document.querySelector("#players");
    players.replaceChildren();
    response.players.forEach((player) => {
        const li = document.createElement("li")
        li.innerText = player
        players.appendChild(li);
    });

    getUpdate();
}

document.addEventListener("DOMContentLoaded", function(event) {
    getUpdate();
});