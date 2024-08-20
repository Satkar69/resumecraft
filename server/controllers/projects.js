import asyncHandler from "../utils/asyncHandler.js";
import {
  createProj,
  findAllProj,
  findProjById,
  deleteProjById,
  updateProjById,
} from "../services/projects.js";

export const createProject = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const project = await createProj(data);
  return res.status(201).json({
    status: "success",
    statuscode: 200,
    project,
  });
});

export const getProjects = asyncHandler(async (req, res, next) => {
  const projects = await findAllProj();
  return res.status(200).json({
    status: "success",
    statuscode: 200,
    projects,
  });
});

export const getProject = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const project = await findProjById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    project,
  });
});

export const deleteProject = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const project = await deleteProjById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    project,
  });
});

export const updateProject = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const project = await updateProjById(id, data);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    project,
  });
});
