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
