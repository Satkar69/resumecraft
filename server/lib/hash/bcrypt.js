import bcrypt from "bcrypt";

/**
 * @param {*} plainTextPassword
 * @returns password hash
 */

const saltRounds = 10;

export const hashPassword = async (plainTextPassword) => {
  const salt = await bcrypt.genSalt(saltRounds);
  const hashedPassword = await bcrypt.hash(plainTextPassword, salt);
  return hashedPassword;
};

export const validatePassword = async (userPassword, hash) => {
  return await bcrypt.compare(userPassword, hash);
};
