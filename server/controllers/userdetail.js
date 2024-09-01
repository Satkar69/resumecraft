import asyncHandler from "../utils/asyncHandler.js";
import {
  createUd,
  findAllUd,
  deleteUdById,
  findUdById,
  updateUdById,
  searchUdsByUser,
  generateResumeInfo,
} from "../services/userdetail.js";
import { promises as fs } from "fs";
import path from "path";
import ejs from "ejs";
import puppeteer from "puppeteer";

export const createUserDetail = asyncHandler(async (req, res, next) => {
  const data = req.body;
  const user = req.user;
  data.user = user._id;
  const userdetail = await createUd(data);
  res.status(201).json({
    status: "success",
    statusCode: 201,
    userdetail,
  });
});

export const getUserDetails = asyncHandler(async (req, res, next) => {
  const userdetails = await findAllUd();
  res.status(200).json({
    status: "success",
    statusCode: 200,
    userdetails,
  });
});

export const getUserDetailsByCurrentUser = asyncHandler(
  async (req, res, next) => {
    const user_id = req.user._id;
    const userdetails = await searchUdsByUser(user_id);
    res.status(200).json({
      status: "success",
      statusCode: 200,
      userdetails,
    });
  }
);

export const getUserDetail = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const userdetail = await findUdById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    userdetail,
  });
});

export const deleteUserDetail = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  await deleteUdById(id);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    message: `userdetail deleted successfully!!`,
  });
});

export const updateUserDetail = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const data = req.body;
  const userdetail = await updateUdById(id, data);
  res.status(200).json({
    status: "success",
    statusCode: 200,
    userdetail,
  });
});

export const uploadImage = asyncHandler(async (req, res, next) => {
  if (!req.file) {
    res.status(400).json({
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

export const getResumeInfo = asyncHandler(async (req, res, next) => {
  const id = req.params.id;
  const user_id = req.user._id;
  const userdetail = await generateResumeInfo(id);

  // Render the EJS template to HTML
  const html = await ejs.renderFile(
    path.join(process.cwd(), "views", "resume.ejs"),
    userdetail
  );

  // Launch a headless browser
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  // Set the HTML content of the page
  await page.setContent(html, { waitUntil: "networkidle0" });

  // Generate a unique filename
  const filename = `${userdetail.userdetail[0].fullname}-${id}.pdf`;
  const filePath = path.join(process.cwd(), "public", "pdfs", filename);

  // Ensure the directory exists
  await fs.mkdir(path.join(process.cwd(), "public", "pdfs"), {
    recursive: true,
  });

  // Generate PDF
  await page.pdf({
    path: filePath,
    format: "A4",
    printBackground: true,
  });

  // Close the browser
  await browser.close();

  // Send the download path to the client

  await RESUMEDB.User.findByIdAndUpdate(user_id, {
    $addToSet: { resume: `/pdfs/${filename}` },
  });

  res.status(200).json({
    status: "success",
    statusCode: 200,
    downloadPath: `/pdfs/${filename}`,
    userdetail,
  });
});
