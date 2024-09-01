import 'package:flutter/material.dart';

import 'package:resumecraft/api_services/project_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/projects/read/projects_model.dart';

mixin ProjectsMixin<T extends StatefulWidget> on State<T> {
  List<Projects> projects = [];
  String? personalDetailID;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final personalDetailID = args?['personalDetailID'] as String?;
      if (personalDetailID != null && !_detailsLoaded) {
        setPersonalDetailID(personalDetailID);
      }
    });
  }

  void setPersonalDetailID(String? id) {
    if (personalDetailID != id) {
      personalDetailID = id;
      loadProjects();
    }
  }

  Future<void> loadProjects() async {
    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await ProjectAPIService.getProjectsByPersonalDetail(
            token, personalDetailID!);
        final projs = ProjectsModel.fromJson(data);
        setState(() {
          projects = projs.projects ?? [];
        });
      } catch (e) {
        print('Failed to set projects: $e');
      }
    }
  }
}
