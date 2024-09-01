class Config {
  static const String appName = "resumecraft";
  // static const String apiUrl = "http://localhost:3000/api/"; // for web
  // static const String apiUrl =
  //     "10.0.0.7:4000/api/"; // for android emulator (not working for some reason)

  // 192.168.18.9
  // 192.168.1.65---my
  // 192.168.1.3
  // 192.168.1.2

  //local
  // static const String apiUrl =
  //     "http://192.168.1.65:3000/api/"; // for physical device || andriod emulator
  // static const String getProfileImage =
  //     'http://192.168.1.65:3000/public/images/';
  static const String getPdfs = 'http://192.168.1.65:3000/public';

  //hosted
  static const String apiUrl = "https://resumecraft-backend.vercel.app/api/";
  static const String getProfileImage =
      "https://resumecraft-backend.vercel.app/public/images/";

  // ===================== public Routes ===========================
  static const String login = "auth/login";
  static const String register = "user/register";

  // ===================== Auth Routes ===========================a
  static const String userProfile = "user/profile";

  static const String getPersonalDetails =
      "userdetail/userdetails-by-currentuser";
  static const String createPersonalDetail = 'userdetail/create-userdetail';
  static const String personalDetailByID =
      'userdetail/'; // RUD--> read, update, delete
  static const String uploadProfileImage = 'userdetail/upload-image/';
  static const String generateResume = 'userdetail/generate-resume/';

  static const String createEducation = 'education/create-edu';
  static const String educationsByPersonalDetail =
      "education/edus-by-userdetail/";
  static const String getEducations = 'education';
  static const String educationByID = 'education/';

  static const String createExperience = 'experience/create-exp';
  static const String experiencesByPersonalDetail =
      'experience/exps-by-userdetail/';
  static const String getExperiences = 'experience';
  static const String experienceByID = 'experience/';

  static const String createSkill = 'skills/create-skill';
  static const String skillsByPersonalDetail = 'skills/skills-by-userdetail/';
  static const String getSkills = 'skills';
  static const String skillByID = 'skills/';

  static const String createObjective = 'objective/create-obj';
  static const String objectivesByPersonalDetail =
      'objective/objs-by-userdetail/';
  static const String getObjectives = 'objective';
  static const String objectiveByID = 'objective/';

  static const String createProject = 'projects/create-proj';
  static const String projectsByPersonalDetail =
      'projects/projs-by-userdetail/';
  static const String getProjects = 'projects';
  static const String projectByID = 'projects/';
}
