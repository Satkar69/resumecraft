import asyncHandler from "../utils/asyncHandler.js";
import {
  createObj,
  findAllObj,
  deleteObjById,
  findObjById,
  updateObjById,
  findObjsByUd,
  updateObjByUd,
} from "../services/objective.js";

export const createObjective = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const objective = await createObj(data);
  res.status(201).json({
    status: "success",
    statusCode: 201,
    objective,
  });
});

export const getObjectives = asyncHandler(async (req, res, next) => {
  const objectives = await findAllObj();
  res.status(200).json({
    status: "success",
    statusCode: 200,
    objectives,
  });
});

export const getObjective = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const objective = await findObjById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    objective,
  });
});

export const deleteObjective = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  await deleteObjById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    message: `objective deleted successfully!!`,
  });
});

export const updateObjective = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const objective = await updateObjById(id, data);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    objective,
  });
});

export const getObjectivesByUserDetail = asyncHandler(
  async (req, res, next) => {
    const id = req.params.id;
    const objectives = await findObjsByUd(id);
    res.status(200).json({
      status: "success",
      statusCode: 200,
      objectives,
    });
  }
);

export const updateObjectiveByUserDetail = asyncHandler(
  async (req, res, next) => {
    const id = req.params.id;
    const data = req.body;
    const objective = await updateObjByUd(id, data);
    res.status(200).json({
      status: "success",
      statusCode: 200,
      objective,
    });
  }
);
