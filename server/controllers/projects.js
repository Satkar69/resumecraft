import asyncHandler from "../utils/asyncHandler.js";
import {
  createProj,
  findAllProj,
  findProjById,
  deleteProjById,
  updateProjById,
  findProjsByUd,
  updateProjByUd,
} from "../services/projects.js";

export const createProject = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const project = await createProj(data);
  res.status(201).json({
    status: "success",
    statusCode: 201,
    project,
  });
});

export const getProjects = asyncHandler(async (req, res, next) => {
  const projects = await findAllProj();
  res.status(200).json({
    status: "success",
    statusCode: 200,
    projects,
  });
});

export const getProject = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const project = await findProjById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    project,
  });
});

export const deleteProject = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  await deleteProjById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    message: `project deleted successfully!!`,
  });
});

export const updateProject = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const project = await updateProjById(id, data);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    project,
  });
});

export const getProjectsByUserDetail = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const projects = await findProjsByUd(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    projects,
  });
});

export const updateProjectByUserDetail = asyncHandler(
  async (req, res, next) => {
    const id = req.params.id;
    const data = req.body;
    const project = await updateProjByUd(id, data);
    res.status(200).json({
      status: "success",
      statusCode: 200,
      project,
    });
  }
);
