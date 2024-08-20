/**
 *
 * @param {function} func
 * @returns promise
 *  handles rejected promise
 */

/**
 *
 * slightly more explicit in how it handles the error,
 * which might make it clearer for developers who are less familiar with how promises work.
 */
const asyncHandler = (func) => {
  return (req, res, next) => {
    func(req, res, next).catch((err) => next(err));
  };
};

/**
 * more idiomatic and follows common practices in modern JavaScript for handling asynchronous functions.
 */
// const asyncHandler = (fn) => (req, res, next) =>
//   Promise.resolve(fn(req, res, next)).catch(next);

export default asyncHandler;
