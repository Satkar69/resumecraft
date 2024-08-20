import { devErrors, prodErrors } from "./environment/index.js";
import { validationErrorHandler } from "./validation/index.js";
import {
  castErrorHandler,
  duplicateKeyErrorHandler,
} from "./database/index.js";

const globalErrorHandler = (error, req, res, next) => {
  error.statusCode = error.statusCode || 500;
  error.status = error.status || "error";

  console.log("Entering globalErrorHandler");
  console.log("Environment:", process.env.NODE_ENV);
  console.log("Error:", error);

  if (process.env.NODE_ENV === "development") {
    devErrors(res, error);
  } else if (process.env.NODE_ENV === "production") {
    /**
     * here, error has name property-->invalid_ID/CastError is thrown/caught by mongoose
     */
    if (error.name === "CastError") error = castErrorHandler(error);
    /**
     * here, error has no name property-->duplicatekeyError is thrown/caught by mongodb driver so we identify using error code
     */
    if (error.code === 11000) error = duplicateKeyErrorHandler(error);
    if (error.name === "ValidationError") error = validationErrorHandler(error);
    prodErrors(res, error);
  }
};
export default globalErrorHandler;
