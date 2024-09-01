import { Router } from "express";
import {
  createProject,
  deleteProject,
  getProject,
  getProjectsByUserDetail,
  getProjects,
  updateProject,
} from "../controllers/projects.js";

const router = Router();

router.route("/").get(getProjects);
router.route("/create-proj").post(createProject);

// by project id
router.route("/:id").get(getProject).delete(deleteProject).put(updateProject);

// by userdetail
router.route("/projs-by-userdetail/:id").get(getProjectsByUserDetail);

export default router;
