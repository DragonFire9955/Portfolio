//trail de la souris
const canvas = document.getElementById("comet");
const ctx = canvas.getContext("2d");

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

let mouse = { x: canvas.width / 2, y: canvas.height / 2 };
let tail = [];

//couleur trait et cursor actuel
let trailColor = { r: 220, g: 20, b: 60 }; // rouge par défaut
let targetColor = { r: 220, g: 20, b: 60 }; // couleur cible

//si l'user change la taille de sa fenêtre
window.addEventListener("resize", () => {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
});

//pos souris
document.addEventListener("mousemove", (e) => {
  mouse.x = e.clientX;
  mouse.y = e.clientY;
});

//hover sur elem clickble, je prends même ceux que j'ai pas fait comme ça c déjà fait si jamais
document
  .querySelectorAll("a, button, input, label, [onclick]")
  .forEach((el) => {
    el.addEventListener("mouseenter", () => {
      targetColor = { r: 255, g: 255, b: 255 }; // blanc
    });
    el.addEventListener("mouseleave", () => {
      targetColor = { r: 220, g: 20, b: 60 }; // rouge
    });
  });
//transition fluide de ↑
function lerp(a, b, t) {
  return a + (b - a) * t;
}

function animate() {
  //clear efface le canva à chq frame
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  // Interpolation fluide de la couleur
  trailColor.r = lerp(trailColor.r, targetColor.r, 0.1);
  trailColor.g = lerp(trailColor.g, targetColor.g, 0.1);
  trailColor.b = lerp(trailColor.b, targetColor.b, 0.1);

  //a chq frame, nvm ptn avec (alpha = opacité)
  tail.push({ x: mouse.x, y: mouse.y, alpha: 1, size: 6 });

  //50 particules max, sinon le pc va brûler
  if (tail.length > 50) tail.shift();

  //dessin particules
  for (let i = 0; i < tail.length; i++) {
    const p = tail[i];
    //nvm chemin de dessin
    ctx.beginPath();
    //crée un cercle
    ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);

    //couleur
    ctx.fillStyle = `rgba(${Math.round(trailColor.r)},${Math.round(trailColor.g)},${Math.round(trailColor.b)},${p.alpha})`;
    ctx.fill();

    //effet de glow
    ctx.shadowBlur = 15;
    ctx.shadowColor = `rgba(${Math.round(trailColor.r)},${Math.round(trailColor.g)},${Math.round(trailColor.b)},${p.alpha})`;

    //effet de disparition fluide
    p.alpha -= 0.03;
    p.size *= 0.95;
  }
  //boucle infinie
  requestAnimationFrame(animate);
}

animate();

//cursor souris perso
const cursor = document.querySelector(".cursor");

document.addEventListener("mousemove", (e) => {
  cursor.style.left = e.clientX + "px";
  cursor.style.top = e.clientY + "px";
});

document.addEventListener("click", (e) => {
  const ripple = document.createElement("div");
  ripple.classList.add("ripple");

  ripple.style.left = e.clientX + "px";
  ripple.style.top = e.clientY + "px";

  document.body.appendChild(ripple);

  setTimeout(() => {
    ripple.remove();
  }, 600);
});

//Video planete pour changer à la static one.
document.addEventListener("DOMContentLoaded", () => {
  const video = document.getElementById("videoMainPage");

  video.addEventListener("ended", () => {
    video.src = "Content/PlanetStatic.mp4";
    video.loop = true; // activer la boucle pour la deuxième vidéo
    video.play(); // lancer la lecture
  });
});

//Carrousel Machine Virtuelle
(function () {
  const slideTimeout = 5000;
  const $slides = document.querySelectorAll(".slidesCarrousel");

  let intervalId;
  let currentSlide = 1;
  function slideTo(index) {
    currentSlide =
      index >= $slides.length ? 0 : index < 0 ? $slides.length - 1 : index; //version compacte de si cliquer prev sur slide 0 met slide fin et inversement
    $slides.forEach(
      ($elt) => ($elt.style.transform = `translateX(-${currentSlide * 100}%)`),
    );
  }
  function showSlide() {
    slideTo(currentSlide);
    currentSlide++;
  }
  intervalId = setInterval(showSlide, slideTimeout);
})();

//Base de Données Workspace
//Données fichiers
const folders = {
  script: [
    { type: "sql", src: "RenduFinalBD/SAEBDSQL.sql", name: "Tables.sql" },
    {
      type: "sql",
      src: "RenduFinalBD/SAEBDRequetesSQL.sql",
      name: "Requêtes.sql",
    },
  ],
  imagesModel: [
    { type: "image", src: "RenduFinalBD/imagesModels/mcc.png", name: "MCC" },
    { type: "image", src: "RenduFinalBD/imagesModels/mct.png", name: "MCT" },
    { type: "image", src: "RenduFinalBD/imagesModels/mcd.png", name: "MCD" },
  ],
  descriptif: [
    {
      type: "txt",
      src: "RenduFinalBD/descriptifs/Descriptif-Thématique.txt",
      name: "Thematique.txt",
    },
  ],
};

//Fenêtre Workspace
const workspace = document.getElementById("workspace");
const header = document.getElementById("header");
const content = document.getElementById("content");
const foldersDiv = document.getElementById("folders");
const popup = document.getElementById("popup");
const popupContent = document.getElementById("popupContent");

//Toggle workspace
function toggleWorkspace() {
  workspace.classList.toggle("hidden");
  foldersDiv.style.display = "block";
  content.replaceChildren(); //vide complètement la div pour afficher uniquement le contenu du dossier sélectionné.
}

//Afficher dossiers.
function showFolders() {
  foldersDiv.style.display = "block";
  content.replaceChildren(); //seule la liste des fichiers du dossier sélectionné apparaisse.
}

//Ouvrir un dossier.
function openFolder(name) {
  foldersDiv.style.display = "none";
  content.replaceChildren(); //on vide d'abord.
  const backBtn = document.createElement("button");
  backBtn.textContent = "Retour";
  backBtn.style.backgroundColor = "red";
  backBtn.style.borderRadius = "5px";
  backBtn.onclick = showFolders;

  const title = document.createElement("strong");
  title.textContent = name;

  //On ajoute les éléments à la div content.
  content.appendChild(backBtn);
  content.appendChild(document.createElement("br"));
  content.appendChild(title);
  content.appendChild(document.createElement("br"));
  content.appendChild(document.createElement("br"));

  folders[name].forEach((file) => {
    const span = document.createElement("span");
    span.textContent = file.name;
    span.style.cursor = "pointer";

    if (file.type === "sql") span.onclick = () => toggleFile(file.src, "sql");
    if (file.type === "txt") span.onclick = () => toggleFile(file.src, "txt");
    if (file.type === "image") span.onclick = () => openPopup(file.src);

    const div = document.createElement("div");
    div.className = "file";
    div.appendChild(span);
    content.appendChild(div);
  });
}

//Toggle SQL / TXT
function toggleFile(src, type) {
  const id = type + "-" + src.replace(/\W/g, "");
  const existing = document.getElementById(id);
  if (existing) {
    existing.remove();
    return;
  }

  fetch(src) // en gros ça sert a demander un fichier ou une ressource sur le serveur.
    .then((r) => r.text()) //transforme cette réponse en texte brut.
    .then((text) => {
      const pre = document.createElement("pre"); //crée un <pre>.
      pre.id = id; //donne un id unique.
      pre.textContent = text; //met le texte du fichier dedans.
      content.appendChild(pre); //ajoute le <pre> dans la div content.
    });
}

//Popup PNG.
function openPopup(src) {
  popupContent.replaceChildren(); // on vide d'abord

  const img = document.createElement("img");
  img.src = src;
  img.style.maxWidth = "100%";
  img.style.maxHeight = "100%";
  img.style.objectFit = "contain";
  img.style.border = "1px solid #fff";

  popupContent.appendChild(img);
  popup.classList.remove("hidden");
}
function closePopup() {
  popup.classList.add("hidden");
}

//Drag & Drop.
let isDragging = false,
  startX,
  startY;
header.onmousedown = (e) => {
  isDragging = true;
  startX = e.clientX - workspace.offsetLeft;
  startY = e.clientY - workspace.offsetTop;
};
document.onmousemove = (e) => {
  if (isDragging) {
    workspace.style.left = e.clientX - startX + "px";
    workspace.style.top = e.clientY - startY + "px";
  }
};
document.onmouseup = () => (isDragging = false);
