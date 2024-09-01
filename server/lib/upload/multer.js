import multer from "multer";
import path from "path";
import fs from "fs";
import CustomError from "../../utils/CustomError.js ";

const maxSize = 3 * 1024 * 1024; // 3MB

const ensureDirectoryExistence = (dirPath) => {
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true }); // Creates nested directories if needed
  }
};

const getDestination = (file) => {
  let destinationPath;
  if (file.mimetype === "application/pdf") {
    destinationPath = "public/pdfs";
  } else if (file.mimetype.startsWith("image/")) {
    destinationPath = "public/images";
  } else {
    destinationPath = "public/uploads";
  }

  // Ensure the directory exists
  ensureDirectoryExistence(destinationPath);

  return destinationPath;
};

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const destinationPath = getDestination(file);
    cb(null, destinationPath);
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname);
    const name = path.basename(file.originalname, ext);
    cb(null, `${name}${ext}`);
  },
});

const filterFileType = (req, file, cb) => {
  if (!file.originalname.match(/\.(jpg|jpeg|png|gif|pdf)$/)) {
    return cb(new CustomError("unsupported media type", 415), false);
  }
  cb(null, true);
};

const upload = multer({
  storage: storage,
  fileFilter: filterFileType,
  limits: {
    fileSize: maxSize,
  },
}).single("resumeMedia");

export default upload;
