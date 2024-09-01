import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

// || "c3eQhT789Nbkjsdf90eqi76umnW2";

const jwtSecretKey = process.env.JWT_SECRET;

export const decodeToken = (token) => {
  return jwt.verify(token, jwtSecretKey);
};

export const generateToken = async (payload) => {
  return jwt.sign(payload, jwtSecretKey, { expiresIn: "30d" });
};
