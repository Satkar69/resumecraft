import asyncHandler from "../utils/asyncHandler.js";
import {
  createExp,
  findAllExp,
  deleteExpById,
  findExpById,
  updateExpById,
  findExpsByUd,
  updateExpByUd,
} from "../services/experience.js";

export const createExperience = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const experience = await createExp(data);
  res.status(201).json({
    status: "success",
    statusCode: 201,
    experience,
  });
});

export const getExperiences = asyncHandler(async (req, res, next) => {
  const experiences = await findAllExp();
  res.status(200).json({
    status: "success",
    statusCode: 200,
    experiences,
  });
});

export const getExperience = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const experience = await findExpById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    experience,
  });
});

export const deleteExperience = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  await deleteExpById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    message: `experience deleted successfully!!`,
  });
});

export const updateExperience = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const experience = await updateExpById(id, data);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    experience,
  });
});

export const getExperiencesByUserDetail = asyncHandler(
  async (req, res, next) => {
    const id = req.params.id;
    const experiences = await findExpsByUd(id);
    res.status(200).json({
      status: "success",
      statusCode: 200,
      experiences,
    });
  }
);

export const updateExperienceByUserDetail = asyncHandler(
  async (req, res, next) => {
    const id = req.params.id;
    const data = req.body;
    const experience = await updateExpByUd(id, data);
    res.status(200).json({
      status: "success",
      statusCode: 200,
      experience,
    });
  }
);
