import mongoose from "mongoose";
import { Schema } from "mongoose";

const skills = new Schema({
  userdetail: {
    type: Schema.Types.ObjectId,
    ref: "userdetail",
  },
  skill_name: {
    type: String,
    trim: true,
    default: null,
  },
  skill_percentage: {
    type: String,
    default: null,
  },
});

const Skills = mongoose.model("skills", skills);

export default Skills;
