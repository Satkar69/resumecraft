import { Router } from "express";
import {
  createExperience,
  deleteExperience,
  getExperience,
  getExperiences,
  updateExperience,
} from "../controllers/experience.js";

const router = Router();

router.route("/").get(getExperiences);
router.route("/create-exp").post(createExperience);

router
  .route("/:id")
  .get(getExperience)
  .delete(deleteExperience)
  .put(updateExperience);

export default router;
