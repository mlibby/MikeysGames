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
    getUpdate();
}

document.addEventListener("DOMContentLoaded", function(event) {
    getUpdate();
});