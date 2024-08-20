import { Router } from "express";
import {
  createProject,
  deleteProject,
  getProject,
  getProjects,
  updateProject,
} from "../controllers/projects.js";

const router = Router();

router.route("/").get(getProjects);
router.route("/create-proj").post(createProject);

router.route("/:id").get(getProject).delete(deleteProject).put(updateProject);

export default router;
