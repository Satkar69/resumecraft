// custom error class
import CustomError from "../utils/CustomError.js";

// error handlers
import { hashPassword } from "../lib/hash/bcrypt.js";

export const createUser = async (userData) => {
  const { password } = userData;
  userData.password = await hashPassword(password);
  const user = await RESUMEDB.User.create(userData);
  return user;
};

export const findAllUser = async () => {
  const users = await RESUMEDB.User.find().select(
    "-password -__v -created_at -updated_at"
  );
  return users;
};

export const findUserById = async (user_id) => {
  const user = await RESUMEDB.User.findById(user_id).select("-password -__v");

  if (!user) {
    throw new CustomError(`user with '_id: ${id}' does not exist`, 404);
  }

  return user;
};

export const deleteUserById = async (user_id) => {
  const user = await RESUMEDB.User.findByIdAndDelete(user_id).select(
    "-password -__v"
  );

  if (!user) {
    throw new CustomError(`user with '_id: ${id}' does not exist`, 404);
  }

  return {};
};

export const updateUserById = async (user_id, user_data) => {
  const user = await RESUMEDB.User.findByIdAndUpdate(user_id, user_data, {
    new: true,
    runValidators: true,
  }).select("-password");

  if (!user) {
    throw new CustomError(`user with '_id: ${id}' does not exist`, 404);
  }

  return user;
};
