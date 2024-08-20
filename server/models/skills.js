import mongoose from "mongoose";
import { Schema } from "mongoose";

const skills = new Schema({
  userdetail: {
    type: Schema.ObjectId,
    ref: "userdetail",
  },
  skill_name: {
    type: String,
    trim: true,
    default: "",
  },
  skill_percentage: {
    type: String,
    default: "",
  },
});

const Skills = mongoose.model("skills", skills);

export default Skills;
