import CustomError from "../utils/CustomError.js";

export const createSk = async (skill_data) => {
  const skill = await RESUMEDB.Skills.create(skill_data);
  return skill;
};

export const findAllSkill = async () => {
  const skills = await RESUMEDB.Skills.find().select("-__v");
  return skills;
};

export const findSkillById = async (skill_id) => {
  const skill = await RESUMEDB.Skills.findById(skill_id).select("-__v");

  if (!skill) {
    throw new CustomError(`skill with '_id: ${id}' does not exist`, 404);
  }

  return skill;
};

export const deleteSkillById = async (skill_id) => {
  const skill = await RESUMEDB.Skills.findByIdAndDelete(skill_id);

  if (!skill) {
    throw new CustomError(`skill with '_id: ${id}' does not exist`, 404);
  }

  return {};
};

export const updateSkillById = async (skill_id, skill_data) => {
  const skill = await RESUMEDB.Skills.findByIdAndUpdate(skill_id, skill_data, {
    new: true,
    runValidators: true,
  });

  if (!skill) {
    throw new CustomError(`skill with '_id: ${id}' does not exist`, 404);
  }

  return skill;
};

export const findSkillsByUd = async (userdetailId) => {
  const skills = await RESUMEDB.Skills.find({
    userdetail: userdetailId,
  }).select("-__v");
  if (!skills) {
    throw new CustomError(
      `skills with 'userdetail: ${userdetailId}' does not exist`,
      404
    );
  }

  return skills;
};

export const updateSkillByUd = async (userdetailId, skill_data) => {
  const skill = await RESUMEDB.Skills.findOneAndUpdate(
    { userdetail: userdetailId },
    skill_data,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!skill) {
    throw new CustomError(
      `skill with 'userdetail: ${userdetailId}' does not exist`,
      404
    );
  }

  return skill;
};
