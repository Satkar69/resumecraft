import { Router } from "express";
import {
  createSkill,
  deleteSkill,
  getSkill,
  getSkillsByUserDetail,
  getSkills,
  updateSkill,
} from "../controllers/skills.js";

const router = Router();

router.route("/").get(getSkills);
router.route("/create-skill").post(createSkill);

// by skill id
router.route("/:id").get(getSkill).delete(deleteSkill).put(updateSkill);

// by userdetail
router.route("/skills-by-userdetail/:id").get(getSkillsByUserDetail);

export default router;
