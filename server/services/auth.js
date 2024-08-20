// custom error class
import CustomError from "../utils/CustomError.js";

// error handlers
import { validatePassword } from "../lib/hash/bcrypt.js";
import { generateToken } from "../lib/token/jsonwebtoken.js";

export const verifyUser = async ({ username, email, password }) => {
  const user = await RESUMEDB.User.findOne({
    $or: [{ username: username }, { email: email }],
  });

  if (!user) {
    const error = new CustomError(
      "user with the given username or email does not exist",
      404
    );

    throw error;
  }

  const isValidPassword = await validatePassword(password, user.password);

  if (!isValidPassword) {
    const error = new CustomError("password does not match", 401);
    throw error;
  }

  const token = await generateToken({ id: user._id });

  return token;
};
