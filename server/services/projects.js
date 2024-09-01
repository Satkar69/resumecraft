import CustomError from "../utils/CustomError.js";

export const createProj = async (proj_data) => {
  const project = await RESUMEDB.Projects.create(proj_data);
  return project;
};

export const findAllProj = async () => {
  const projects = await RESUMEDB.Projects.find().select("-__v");
  return projects;
};

export const findProjById = async (proj_id) => {
  const project = await RESUMEDB.Projects.findById(proj_id).select("-__v");

  if (!project) {
    throw new CustomError(`project with '_id: ${id}' does not exist`, 404);
  }

  return project;
};

export const deleteProjById = async (proj_id) => {
  const project = await RESUMEDB.Projects.findByIdAndDelete(proj_id);

  if (!project) {
    throw new CustomError(`project with '_id: ${id}' does not exist`, 404);
  }

  return {};
};

export const updateProjById = async (proj_id, proj_data) => {
  const project = await RESUMEDB.Projects.findByIdAndUpdate(
    proj_id,
    proj_data,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!project) {
    throw new CustomError(`project with '_id: ${id}' does not exist`, 404);
  }

  return project;
};

export const findProjsByUd = async (userdetailId) => {
  const projects = await RESUMEDB.Projects.find({
    userdetail: userdetailId,
  }).select("-__v");
  if (!projects) {
    throw new CustomError(
      `projects with 'userdetail: ${userdetailId}' does not exist`,
      404
    );
  }

  return projects;
};

export const updateProjByUd = async (userdetailId, project_data) => {
  const project = await RESUMEDB.Projects.findOneAndUpdate(
    { userdetail: userdetailId },
    project_data,
    {
      new: true,
      runValidators: true,
    }
  );

  if (!project) {
    throw new CustomError(
      `project with 'userdetail: ${userdetailId}' does not exist`,
      404
    );
  }

  return project;
};
