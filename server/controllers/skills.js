import asyncHandler from "../utils/asyncHandler.js";
import {
  createSk,
  findAllSkill,
  deleteSkillById,
  findSkillById,
  updateSkillById,
} from "../services/skills.js";

export const createSkill = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const skill = await createSk(data);
  return res.status(201).json({
    status: "success",
    statuscode: 200,
    skill,
  });
});

export const getSkills = asyncHandler(async (req, res, next) => {
  const skills = await findAllSkill();
  return res.status(200).json({
    status: "success",
    statuscode: 200,
    skills,
  });
});

export const getSkill = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const skill = await findSkillById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    skill,
  });
});

export const deleteSkill = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const skill = await deleteSkillById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    skill,
  });
});

export const updateSkill = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const skill = await updateSkillById(id, data);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    skill,
  });
});
