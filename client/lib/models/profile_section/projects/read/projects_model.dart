class ProjectsModel {
  String? status;
  int? statusCode;
  List<Projects>? projects;

  ProjectsModel({this.status, this.statusCode, this.projects});

  ProjectsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Projects {
  String? id;
  String? userdetail;
  String? projectTitle;
  String? projectDesc;
  List<String>? links;

  Projects(
      {this.id,
      this.userdetail,
      this.projectTitle,
      this.projectDesc,
      this.links});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userdetail = json['userdetail'];
    projectTitle = json['project_title'];
    projectDesc = json['project_desc'];
    if (json['links'] != null) {
      links = List<String>.from(json['links']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userdetail'] = userdetail;
    data['project_title'] = projectTitle;
    data['project_desc'] = projectDesc;
    if (links != null) {
      data['links'] = links;
    }
    return data;
  }
}
