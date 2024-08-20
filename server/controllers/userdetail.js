import asyncHandler from "../utils/asyncHandler.js";
import {
  createUd,
  findAllUd,
  deleteUdById,
  findUdById,
  updateUdById,
} from "../services/userdetail.js";

export const createUserDetail = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const user = req.user;
  data.user = user._id;
  const userdetail = await createUd(data);
  return res.status(201).json({
    status: "success",
    statuscode: 200,
    userdetail,
  });
});

export const getUserDetails = asyncHandler(async (req, res, next) => {
  const userdetails = await findAllUd();
  return res.status(200).json({
    status: "success",
    statuscode: 200,
    userdetails,
  });
});

export const getUserDetail = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const userdetail = await findUdById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    userdetail,
  });
});

export const deleteUserDetail = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const userdetail = await deleteUdById(id);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    userdetail,
  });
});

export const updateUserDetail = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const userdetail = await updateUdById(id, data);
  return res.status(200).json({
    status: "success",
    statusCode: 200,
    userdetail,
  });
});

export const uploadImage = asyncHandler(async (req, res, next) => {
  if (!req.file) {
    return res.status(400).json({
      status: "fail",
      statusCode: 400,
      message: "file must be uploaded!",
    });
  }
  res.status(200).json({
    status: "success",
    statusCode: 200,
    file: req.file,
  });
});
