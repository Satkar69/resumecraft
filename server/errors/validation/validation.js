import CustomError from "../../utils/CustomError.js";

const validationErrorHandler = (error) => {
  const errors = Object.values(error.errors).map((value) => value.message);
  const errorMessages = errors.join(" | ");
  const message = `Invalid Input : / ${errorMessages} /`;
  return new CustomError(message, 400);
};

export default validationErrorHandler;
