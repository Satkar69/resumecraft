import mongoose from "mongoose";
import { Schema } from "mongoose";

const objective = new Schema({
  userdetail: {
    type: Schema.Types.ObjectId,
    ref: "userdetail",
  },
  details: {
    type: String,
    default: null,
  },
});

const Objective = mongoose.model("objective", objective);

export default Objective;
