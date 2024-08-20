const devErrors = (res, error) => {
  res.status(error.statusCode).json({
    statusCode: error.statusCode,
    message: error.message,
    stackTrace: error.stack,
    error: error,
  });
};

export default devErrors;
