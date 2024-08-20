import multer from "multer";
import path from "path";
import CustomError from "../../utils/CustomError.js ";

const maxSize = 3 * 1024 * 1024; // 3MB

const getDestination = (file) => {
  if (file.mimetype === "application/pdf") {
    return "public/pdfs";
  } else if (file.mimetype.startsWith("image/")) {
    return "public/images";
  } else {
    //default to a generic uploads folder or throw an error
    return "public/uploads";
  }
};

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const destinationPath = getDestination(file);
    cb(null, destinationPath);
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname);
    cb(null, `${file.originalname}-${Date.now()}` + ext);
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
