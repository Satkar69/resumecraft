import CustomError from "../utils/CustomError.js";
import asyncHandler from "../utils/asyncHandler.js";
import { decodeToken } from "../lib/token/jsonwebtoken.js";

const authenticate = asyncHandler(async (req, res, next) => {
  let token;

  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("Bearer")
  ) {
    console.log("token via authorization header bearer");
    token = req.headers.authorization.split(" ")[1]; // set via client
  } else if (req.cookies.token) {
    console.log("token via cookie storage");
    token = req.cookies.token; // for testing apis in server side
  }

  if (!token) {
    const error = new CustomError("Authentication token is missing", 401);
    return next(error);
  }

  try {
    const decoded_data = decodeToken(token);

    const user_id = decoded_data.id;

    const user = await RESUMEDB.User.findOne({ _id: user_id }).select(
      "-password -__v"
    );

    if (!user) {
      const error = new CustomError("User not found", 404);
      return next(error);
    }

    req.user = user;

    next();
  } catch (error) {
    const message = "Invalid token";
    console.log(error);
    const err = new CustomError(message, 401);
    return next(err);
  }
});

export default authenticate;
