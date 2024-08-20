import CustomError from "../../utils/CustomError.js";

const castErrorHandler = (error) => {
  const message = `Invalid value for '${error.path}: ${error.value}'`;
  return new CustomError(message, 400); // status code : 400 :: bad request
};

export default castErrorHandler;
