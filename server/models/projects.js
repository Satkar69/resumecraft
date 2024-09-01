import mongoose from "mongoose";
import { Schema } from "mongoose";

const projects = new Schema({
  userdetail: {
    type: Schema.Types.ObjectId,
    ref: "userdetail",
  },
  project_title: {
    type: String,
    trim: true,
    default: null,
  },
  project_desc: {
    type: String,
    trim: true,
    default: null,
  },
  links: {
    type: [String],
    default: [],
  },
});

const Projects = mongoose.model("projects", projects);

export default Projects;
