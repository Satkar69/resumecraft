import { Router } from "express";
import {
  createEducation,
  deleteEducation,
  getEducation,
  getEducations,
  updateEducation,
} from "../controllers/education.js";

const router = Router();

router.route("/").get(getEducations);
router.route("/create-edu").post(createEducation);

router
  .route("/:id")
  .get(getEducation)
  .delete(deleteEducation)
  .put(updateEducation);

export default router;
