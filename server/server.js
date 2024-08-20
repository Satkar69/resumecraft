import express from "express";

//error handling
import CustomError from "./utils/CustomError.js";
import globalErrorHandler from "./errors/index.js";

// database
import "./database/index.js";
import db from "./models/index.js";

//routes
import appRouter from "./routes/index.js";

//
import dotenv from "dotenv";
import cookieParser from "cookie-parser";

const app = express();

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

dotenv.config();

// body parser for request body
app.use(express.json());

//Parse Cookie header and populate req.cookies with an object keyed by the cookie names
app.use(cookieParser());

app.use(appRouter);

app.all("*", async (req, res, next) => {
  const error = new CustomError(`can't find ${req.url} on the server!`, 404);
  next(error);
});

app.use(globalErrorHandler);

export default app;
