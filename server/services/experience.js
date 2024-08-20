import CustomError from "../utils/CustomError.js";

export const createExp = async (exp_data) => {
  const experience = await RESUMEDB.Experience.create(exp_data);
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
