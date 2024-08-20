import CustomError from "../utils/CustomError.js";

export const createUd = async (user_detail) => {
  const userdetail = await RESUMEDB.UserDetail.create(user_detail);
  return userdetail;
};

export const findAllUd = async () => {
  const userdetails = await RESUMEDB.UserDetail.find().select("-__v");
  return userdetails;
};

export const findUdById = async (user_detail_id) => {
  const userdetail = await RESUMEDB.UserDetail.findById(user_detail_id).select(
    "-__v"
  );

  if (!userdetail) {
    throw new CustomError(
      `userdetail with '_id: ${user_detail_id}' does not exist`,
      404
    );
  }

  return userdetail;
};

export const deleteUdById = async (user_detail_id) => {
  const userdetail = await RESUMEDB.UserDetail.findByIdAndDelete(
    user_detail_id
  );

  if (!userdetail) {
    throw new CustomError(
      `userdetail with '_id: ${user_detail_id}' does not exist`,
      404
    );
  }

  return {};
};

export const updateUdById = async (user_detail_id, user_detail) => {
  const userdetail = await RESUMEDB.UserDetail.findByIdAndUpdate(
    user_detail_id,
    user_detail,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!userdetail) {
    throw new CustomError(
      `userdetail with '_id: ${user_detail_id}' does not exist`,
      404
    );
  }

  return userdetail;
};
