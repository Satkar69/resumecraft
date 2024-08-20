import { Router } from "express";
import {
  createObjective,
  deleteObjective,
  getObjective,
  getObjectives,
  updateObjective,
} from "../controllers/objective.js";
import authenticate from "../middlewares/auth.js";

const router = Router();

router.route("/").get(getObjectives);
router.route("/create-obj").post(createObjective);

router
  .route("/:id")
  .get(getObjective)
  .delete(deleteObjective)
  .put(updateObjective);

export default router;
