import asyncHandler from "../utils/asyncHandler.js";
import {
  createExp,
  findAllExp,
  deleteExpById,
  findExpById,
  updateExpById,
} from "../services/experience.js";

export const createExperience = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const experience = await createExp(data);
  return res.status(201).json({
    status: "success",
    statuscode: 200,
    experience,
  });
});

export const getExperiences = asyncHandler(async (req, res, next) => {
  const experiences = await findAllExp();
  return res.status(200).json({
    status: "success",
    statuscode: 200,
    experiences,
  });
});

export const getExperience = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const experience = await findExpById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    experience,
  });
});

export const deleteExperience = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const experience = await deleteExpById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    experience,
  });
});

export const updateExperience = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const experience = await updateExpById(id, data);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    experience,
  });
});
