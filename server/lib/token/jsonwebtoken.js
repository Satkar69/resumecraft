import jwt from "jsonwebtoken";

const jwtSecretKey = process.env.JWT_SECRET || "c3eQhT789Nbkjsdf90eqi76umnW2";

export const decodeToken = (token) => {
  return jwt.verify(token, jwtSecretKey);
};

export const generateToken = async (payload) => {
  return jwt.sign(payload, jwtSecretKey, { expiresIn: "1h" });
};
