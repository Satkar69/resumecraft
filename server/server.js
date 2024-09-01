import express from "express";
import dotenv from "dotenv";
dotenv.config();
import cookieParser from "cookie-parser";
import path from "path";
import { fileURLToPath } from "url";
import cors from "cors";
//error handling
import CustomError from "./utils/CustomError.js";
import globalErrorHandler from "./errors/index.js";
import morgan from "morgan";
// database
import "./database/index.js";
import db from "./models/index.js";
//routes
import appRouter from "./routes/index.js";

// Create __dirname equivalent
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

//set the view engine to ejs
app.set("view engine", "ejs");

const PORT = process.env.PORT || 3000;

const server = app.listen(PORT, () => {
  console.log(`Running on port ${PORT}`);
});

process.on("uncaughtException", (err) => {
  console.log(err.name, err.message);
  console.log("uncaught exception occured!!, shutting down...");
});

process.on("unhandledRejection", (err) => {
  console.log(err.name, err.message);
  console.log("unhandled rejection occurred!!, shutting down...");
  server.close(() => {
    process.exit(1);
  });
});

global.RESUMEDB = db; // use the database orm globally without a need for importing everytime

// body parser for request body
app.use(express.json());

// for logging http requests
app.use(morgan("dev"));

//Parse Cookie header and populate req.cookies with an object keyed by the cookie names
app.use(cookieParser());

app.use(cors("*"));

// static file server, here for the images
app.use("/public", express.static(__dirname + "/public"));

app.use(appRouter);

app.all("*", async (req, res, next) => {
  const error = new CustomError(`can't find ${req.url} on the server!`, 404);
  next(error);
});

app.use(globalErrorHandler);

export default app;
