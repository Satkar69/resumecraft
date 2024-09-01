// error handlers
import asyncHandler from "../utils/asyncHandler.js";

//services
import {
  createUser,
  findAllUser,
  findUserById,
  deleteUserById,
  updateUserById,
} from "../services/user.js";

/**
 * @param {*} req
 * @param {*} res
 * @returns json containing newly created user object
 */

export const register = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const user = await createUser(data);
  res.status(201).json({
    status: "success",
    statusCode: 201,
    user,
  });
});

/**
 * @param {*} req
 * @param {*} res
 * @returns json containing a list of user objects
 */
export const getUsers = asyncHandler(async (req, res, next) => {
  const users = await findAllUser();

  res.status(200).json({
    status: "success",
    statusCode: 200,
    length: users.length,
    users,
  });
});

export const getUser = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const user = await findUserById(id);

  res.status(200).json({
    status: "success",
    statusCode: 200,
    user,
  });
});

export const deleteUser = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  await deleteUserById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    message: `user deleted successfully!!`,
  });
});

export const updateUser = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const user = await updateUserById(id, data);

  res.status(201).json({
    status: "success",
    statusCode: 201,
    user,
  });
});

export const profile = asyncHandler(async (req, res, next) => {
  const user = req.user;
  res.status(200).json({
    user,
  });
});
