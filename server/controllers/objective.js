import asyncHandler from "../utils/asyncHandler.js";
import {
  createObj,
  findAllObj,
  deleteObjById,
  findObjById,
  updateObjById,
} from "../services/objective.js";

export const createObjective = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const objective = await createObj(data);
  return res.status(201).json({
    status: "success",
    statuscode: 200,
    objective,
  });
});

export const getObjectives = asyncHandler(async (req, res, next) => {
  const objectives = await findAllObj();
  return res.status(200).json({
    status: "success",
    statuscode: 200,
    objectives,
  });
});

export const getObjective = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const objective = await findObjById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    objective,
  });
});

export const deleteObjective = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const objective = await deleteObjById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    objective,
  });
});

export const updateObjective = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const objective = await updateObjById(id, data);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    objective,
  });
});
