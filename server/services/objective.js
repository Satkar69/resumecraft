import CustomError from "../utils/CustomError.js";

export const createObj = async (obj_data) => {
  const objective = await RESUMEDB.Objective.create(obj_data);
  return objective;
};

export const findAllObj = async () => {
  const objectives = await RESUMEDB.Objective.find().select("-__v");
  return objectives;
};

export const findObjById = async (obj_id) => {
  const objective = await RESUMEDB.Objective.findById(obj_id).select("-__v");

  if (!objective) {
    throw new CustomError(`objective with '_id: ${id}' does not exist`, 404);
  }

  return objective;
};

export const deleteObjById = async (obj_id) => {
  const objective = await RESUMEDB.Objective.findByIdAndDelete(obj_id);

  if (!objective) {
    throw new CustomError(`objective with '_id: ${id}' does not exist`, 404);
  }

  return {};
};

export const updateObjById = async (obj_id, obj_data) => {
  const objective = await RESUMEDB.Objective.findByIdAndUpdate(
    obj_id,
    obj_data,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!objective) {
    throw new CustomError(`objective with '_id: ${id}' does not exist`, 404);
  }

  return objective;
};

export const findObjsByUd = async (userdetailId) => {
  const objectives = await RESUMEDB.Objective.find({
    userdetail: userdetailId,
  }).select("-__v");
  if (!objectives) {
    throw new CustomError(
      `objectives with 'userdetail: ${userdetailId}' does not exist`,
      404
    );
  }

  return objectives;
};

export const updateObjByUd = async (userdetailId, obj_data) => {
  const objective = await RESUMEDB.Objective.findOneAndUpdate(
    { userdetail: userdetailId },
    obj_data,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!objective) {
    throw new CustomError(
      `objective with 'userdetail: ${userdetailId}' does not exist`,
      404
    );
  }

  return objective;
};
