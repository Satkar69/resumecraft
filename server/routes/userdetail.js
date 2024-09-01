import { Router } from "express";
import {
  createUserDetail,
  deleteUserDetail,
  getResumeInfo,
  getUserDetail,
  getUserDetails,
  getUserDetailsByCurrentUser,
  updateUserDetail,
  uploadImage,
} from "../controllers/userdetail.js";
import upload from "../lib/upload/multer.js";
import multer from "multer";
import CustomError from "../utils/CustomError.js";

const router = Router();

router.route("/").get(getUserDetails);
router.route("/create-userdetail").post(createUserDetail);
router.route("/userdetails-by-currentuser").get(getUserDetailsByCurrentUser);

router
  .route("/:id")
  .get(getUserDetail)
  .delete(deleteUserDetail)
  .put(updateUserDetail);

router.route("/upload-image").post(upload, (req, res, next) => {
  try {
    uploadImage(req, res);
  } catch (err) {
    if (err instanceof multer.MulterError) {
      next(new CustomError(err.message, 400));
    } else if (err) {
      next(new CustomError(err.message, 400));
    }
  }
});

router.route("/generate-resume/:id").get(getResumeInfo);

export default router;
