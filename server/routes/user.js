import { Router } from "express";
import authenticate from "../middlewares/auth.js";
import {
  getUsers,
  register,
  getUser,
  deleteUser,
  updateUser,
  profile,
} from "../controllers/user.js";

const router = Router();

// public routes
router.route("/").get(getUsers);
router.route("/register").post(register);

// authenticated routes only
router.use(authenticate);

router.route("/profile").get(profile);
router.route("/:id").get(getUser).delete(deleteUser).put(updateUser);

export default router;
