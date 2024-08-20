import { Router } from "express";
import user from "./user.js";
import auth from "./auth.js";
import education from "./education.js";
import experience from "./experience.js";
import skills from "./skills.js";
import objective from "./objective.js";
import projects from "./projects.js";
import userdetail from "./userdetail.js";

import authenticate from "../middlewares/auth.js";

const router = Router();

// authentication and register
router.use("/api/user", user);
router.use("/api/auth", auth);

// authenticated routes
router.use(authenticate);

router.use("/api/userdetail", userdetail);
router.use("/api/education", education);
router.use("/api/experience", experience);
router.use("/api/skills", skills);
router.use("/api/objective", objective);
router.use("/api/projects", projects);

export default router;
