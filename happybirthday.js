/*let w =(c.width = window.innerWidth),
    h = (c.height = window.innerHeight),
    ctx = c.getContext("2d"),
    hw = w / 2;
    (hh = h / 2),
    (opts = {
        strings: ["HAPPY", "BIRTHDAY", "to You"],
        charSize:30,
        charSpacing:35,
        lineHeight:40,

        cx: w / 2,
        cy: h / 2,
        fireworkPrevPoints: 10,
        fireworkBaseLineWidth: 5,
        fireworkAddedLineWidth: 8,
        fireworkSpawnTime: 200,
        fireworkBaseReachTime: 30,
        fireworkAddedReachTime: 30,
        fireworkCircleBaseSize: 30,
        fireworkCircleAddedSize: 10,
    });*/

    // JavaScript code in happybirthday.js

    const c = document.getElementById("c"),
    ctx = c.getContext("2d");

let w = (c.width = window.innerWidth),
    h = (c.height = window.innerHeight);

// Resize canvas on window resize
window.addEventListener("resize", () => {
    w = c.width = window.innerWidth;
    h = c.height = window.innerHeight;
});

const fireworks = [];
const words = "Happy Birthday to You";
const consonants = words.replace(/[aeiou\s]/gi, ''); // Only consonants, excluding vowels and spaces
let consonantIndex = 0;
let showingConsonants = false; // Control when to start showing consonants
let consonantDelay = 1500; // Delay between each consonant reveal (in ms) - Now slower
let fireworkStartTime, wordRevealStartTime;

const opts = {
    fireworkRadius: 5,
    fireworkParticles: 50,
    fireworkSpeed: 4,
    fireworkLife: 30,
    textFont: "bold 50px Arial",
    textColor: "white",
    fireworkDisplayDuration: 5000, // Firework will run for 5 seconds before showing text
};

// Firework particle constructor
function Particle(x, y, color) {
    this.x = x;
    this.y = y;
    this.color = color;
    this.angle = Math.random() * 2 * Math.PI;
    this.speed = opts.fireworkSpeed * Math.random();
    this.life = opts.fireworkLife;
    this.size = opts.fireworkRadius * Math.random();
}

// Firework constructor
function Firework() {
    this.x = Math.random() * w;
    this.y = Math.random() * h / 2; // Fireworks spawn only in the upper half
    this.color = `hsl(${Math.random() * 360}, 100%, 50%)`;
    this.particles = [];

    for (let i = 0; i < opts.fireworkParticles; i++) {
        this.particles.push(new Particle(this.x, this.y, this.color));
    }
}

// Update and draw firework particles
Firework.prototype.update = function () {
    this.particles.forEach((particle, index) => {
        particle.x += Math.cos(particle.angle) * particle.speed;
        particle.y += Math.sin(particle.angle) * particle.speed;
        particle.life--;

        if (particle.life <= 0) {
            this.particles.splice(index, 1);
        }
    });
};

Firework.prototype.draw = function () {
    this.particles.forEach((particle) => {
        ctx.fillStyle = particle.color;
        ctx.beginPath();
        ctx.arc(particle.x, particle.y, particle.size, 0, 2 * Math.PI);
        ctx.fill();
    });
};

// Generate fireworks for the specified duration
function generateFireworks() {
    if (Date.now() - fireworkStartTime < opts.fireworkDisplayDuration) {
        fireworks.push(new Firework());
    } else {
        showingConsonants = true; // Start revealing consonants after fireworks finish
    }

    fireworks.forEach((firework, index) => {
        firework.update();
        firework.draw();

        if (firework.particles.length === 0) {
            fireworks.splice(index, 1);
        }
    });
}

// Draw the consonants one by one
function drawConsonants() {
    if (!showingConsonants) return;

    ctx.fillStyle = opts.textColor;
    ctx.font = opts.textFont;
    ctx.textAlign = "center";

    let textToShow = consonants.slice(0, consonantIndex + 1); // Reveal consonants progressively
    ctx.fillText(textToShow, w / 2, h / 2);

    // Update the consonant index after a delay
    if (Date.now() - wordRevealStartTime > consonantDelay * consonantIndex) {
        consonantIndex++;
        if (consonantIndex >= consonants.length) {
            resetAnimation(); // Reset once all consonants are shown
        }
    }
}

// Reset the animation for looping
function resetAnimation() {
    fireworkStartTime = Date.now();
    wordRevealStartTime = Date.now();
    showingConsonants = false;
    consonantIndex = 0; // Reset consonant index
}

// Main animation loop
function loop() {
    ctx.clearRect(0, 0, w, h);

    generateFireworks(); // Animate fireworks first
    drawConsonants();    // Then display consonants

    requestAnimationFrame(loop);
}

fireworkStartTime = Date.now(); // Start the fireworks
wordRevealStartTime = Date.now(); // Time tracking for consonant reveal
loop(); // Start the drawing loop
