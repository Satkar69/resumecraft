import { Router } from "express";
import {
  createExperience,
  deleteExperience,
  getExperience,
  getExperiencesByUserDetail,
  getExperiences,
  updateExperience,
} from "../controllers/experience.js";

const router = Router();

router.route("/").get(getExperiences);
router.route("/create-exp").post(createExperience);

//by experience id
router
  .route("/:id")
  .get(getExperience)
  .delete(deleteExperience)
  .put(updateExperience);

// by userdetail
router.route("/exps-by-userdetail/:id").get(getExperiencesByUserDetail);

export default router;
