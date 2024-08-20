import CustomError from "../../utils/CustomError.js";

const duplicateKeyErrorHandler = (error) => {
  const keyValue = error.keyValue;
  const message = `A keyValue pair '${Object.keys(keyValue)} : ${Object.values(
    keyValue
  )}' already exists`;
  return new CustomError(message, 400);
};

export default duplicateKeyErrorHandler;
