import mongoose from "mongoose";
import { Schema } from "mongoose";

const projects = new Schema({
  userdetail: {
    type: Schema.ObjectId,
    ref: "userdetail",
  },
  project_title: {
    type: String,
    trim: true,
    default: "",
  },
  project_desc: {
    type: String,
    trim: true,
    default: "",
  },
  links: {
    type: [String],
    default: [],
  },
});

const Projects = mongoose.model("projects", projects);

export default Projects;
