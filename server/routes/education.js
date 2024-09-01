import { Router } from "express";
import {
  createEducation,
  deleteEducation,
  getEducation,
  getEducationsByUserDetail,
  getEducations,
  updateEducation,
} from "../controllers/education.js";

const router = Router();

router.route("/").get(getEducations);
router.route("/create-edu").post(createEducation);

// by education id
router
  .route("/:id")
  .get(getEducation)
  .delete(deleteEducation)
  .put(updateEducation);

// by userdetail
router.route("/edus-by-userdetail/:id").get(getEducationsByUserDetail);

export default router;
