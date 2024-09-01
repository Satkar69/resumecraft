import CustomError from "../utils/CustomError.js";

export const createExp = async (exp_data) => {
  const experience = await RESUMEDB.Experience.create(exp_data);
  // await RESUMEDB.UserDetail.updateOne(
  //   { _id: experience.userdetail },
  //   { $push: { experience: experience._id } }
  // );
  return experience;
};

export const findAllExp = async () => {
  const experiences = await RESUMEDB.Experience.find().select("-__v");
  return experiences;
};

export const findExpById = async (exp_id) => {
  const experience = await RESUMEDB.Experience.findById(exp_id).select("-__v");

  if (!experience) {
    throw new CustomError(`experience with '_id: ${id}' does not exist`, 404);
  }

  return experience;
};

export const deleteExpById = async (exp_id) => {
  const experience = await RESUMEDB.Experience.findByIdAndDelete(exp_id);

  if (!experience) {
    throw new CustomError(`experience with '_id: ${id}' does not exist`, 404);
  }

  return {};
};

export const updateExpById = async (exp_id, exp_data) => {
  const experience = await RESUMEDB.Experience.findByIdAndUpdate(
    exp_id,
    exp_data,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!experience) {
    throw new CustomError(`experience with '_id: ${id}' does not exist`, 404);
  }

  return experience;
};

export const findExpsByUd = async (userdetailId) => {
  const experiences = await RESUMEDB.Experience.find({
    userdetail: userdetailId,
  }).select("-__v");
  if (!experiences) {
    throw new CustomError(
      `experiences with 'userdetail: ${userdetailId}' does not exist`,
      404
    );
  }

  return experiences;
};

export const updateExpByUd = async (userdetailId, exp_data) => {
  const experience = await RESUMEDB.Experience.findOneAndUpdate(
    { userdetail: userdetailId },
    exp_data,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!experience) {
    throw new CustomError(
      `experience with 'userdetail: ${userdetailId}' does not exist`,
      404
    );
  }

  return experience;
};
