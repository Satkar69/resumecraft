import asyncHandler from "../utils/asyncHandler.js";
import {
  createEdu,
  findAllEdu,
  deleteEduById,
  findEduById,
  updateEduById,
} from "../services/education.js";

export const createEducation = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const education = await createEdu(data);
  return res.status(201).json({
    status: "success",
    statuscode: 200,
    education,
  });
});

export const getEducations = asyncHandler(async (req, res, next) => {
  const educations = await findAllEdu();
  return res.status(200).json({
    status: "success",
    statuscode: 200,
    educations,
  });
});

export const getEducation = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const education = await findEduById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    education,
  });
});

export const deleteEducation = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const education = await deleteEduById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    education,
  });
});

export const updateEducation = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const education = await updateEduById(id, data);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    education,
  });
});
