import asyncHandler from "../utils/asyncHandler.js";
import { verifyUser } from "../services/auth.js";

export const login = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const { username, email, password } = data;
  const token = await verifyUser({ username, email, password });
  const options = {
    expires: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // Cookie will expire in 30 days
    httpOnly: true,
  };
  if (process.env.NODE_ENV === "production") {
    options.secure = true; // use this for production environment only
  }
  res.status(200).cookie("token", token, options).json({
    status: "success",
    statusCode: 200,
    token,
  });
});

export const logout = asyncHandler(async (req, res, next) => {
  res.cookie("token", "", { expires: new Date(0), httpOnly: true });
  res.status(200).json({
    status: "success",
    statusCode: 200,
    message: "Logged out successfully!!",
  });
});
