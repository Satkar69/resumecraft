import { Router } from "express";
import {
  createSkill,
  deleteSkill,
  getSkill,
  getSkills,
  updateSkill,
} from "../controllers/skills.js";

const router = Router();

router.route("/").get(getSkills);
router.route("/create-skill").post(createSkill);

router.route("/:id").get(getSkill).delete(deleteSkill).put(updateSkill);

export default router;
