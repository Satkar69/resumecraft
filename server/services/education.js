import CustomError from "../utils/CustomError.js";

export const createEdu = async (edu_data) => {
  const education = await RESUMEDB.Education.create(edu_data);
  return education;
};

export const findAllEdu = async () => {
  const educations = await RESUMEDB.Education.find().select("-__v");
  return educations;
};

export const findEduById = async (edu_id) => {
  const education = await RESUMEDB.Education.findById(edu_id).select("-__v");

  if (!education) {
    throw new CustomError(`education with '_id: ${id}' does not exist`, 404);
  }

  return education;
};

export const deleteEduById = async (edu_id) => {
  const education = await RESUMEDB.Education.findByIdAndDelete(edu_id);

  if (!education) {
    throw new CustomError(`education with '_id: ${id}' does not exist`, 404);
  }

  return {};
};

export const updateEduById = async (edu_id, edu_data) => {
  const education = await RESUMEDB.Education.findByIdAndUpdate(
    edu_id,
    edu_data,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!education) {
    throw new CustomError(`education with '_id: ${id}' does not exist`, 404);
  }

  return education;
};
