const fs = require("fs");
const path = require("path");

const BASE_DIR =
  "/mnt/data/OneDrive/Media/Images/Galerie Samsung/DCIM/Meme/";

const filesNames = fs.readdirSync(BASE_DIR);
const toDelete = [];

filesNames.forEach(fileName => {
  const fileNameWithoutExt = fileName.replace(/\.(jpg|png|gif)/gi, "");

  const dupe = filesNames.find(name => {
    const dupeRegexp = new RegExp(`${fileNameWithoutExt}_01.*`, "gi");

    return name.match(dupeRegexp);
  });

  if (dupe) {
    toDelete.push(fileName);
  }
});

toDelete.forEach(fileName => {
  fs.unlink(path.join(BASE_DIR, fileName), () => {
    console.log(`Deleted ${fileName}`);
  });
});
