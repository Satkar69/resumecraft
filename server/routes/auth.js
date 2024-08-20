import { Router } from "express";
import authenticate from "../middlewares/auth.js";

import { login, logout } from "../controllers/auth.js";

const router = Router();

router.route("/login").post(login);

router.use(authenticate);

router.route("/logout").post(logout);

export default router;
