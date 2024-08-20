/**
 * Custom error class that extends the built-in Error class.
 * Adds a status code and status message to the error.
 */

class CustomError extends Error {
  /**
   * Creates a new CustomError instance.
   *
   * @param {string} message - The error message.
   * @param {number} statusCode - The HTTP status code.
   */

  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode;
    this.status = statusCode >= 400 && statusCode < 500 ? "fail" : "error";
    // indicates if the error is operational
    this.isOperational = true;
    Error.captureStackTrace(this, this.constructor);
  }
}

export default CustomError;

// statusCode 400 - 499 'fail' (client errors) 500-599 'error' (server errors)
