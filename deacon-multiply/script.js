function cloneImage(event) {
  const originalImage = document.getElementById("hiddenImage");
  const clonedImage = originalImage.cloneNode(true);

  const x = event.clientX;
  const y = event.clientY;

  clonedImage.style.position = "absolute";
  clonedImage.style.top = `${y - 100 / 2}px`;
  clonedImage.style.left = `${x - 100 / 2}px`;

  clonedImage.style.visibility = "visible";
  clonedImage.style.width = "100px";
  clonedImage.style.height = "100px";

  document.body.appendChild(clonedImage);
}

document.addEventListener("click", cloneImage);
