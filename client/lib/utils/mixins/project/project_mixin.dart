import 'package:flutter/material.dart';
import 'package:resumecraft/api_services/project_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/projects/read/project_model.dart';

mixin ProjectMixin<T extends StatefulWidget> on State<T> {
  Project? project;
  String? projectID;
  String? personalDetailID;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Optionally, you might not call _loadEducation here if id is not set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final projectID = args?['projectID'] as String?;
      final personalDetailID = args?['personalDetailID'] as String?;

      setPersonalDetailID(personalDetailID);

      if (projectID != null && !_detailsLoaded) {
        setProjectID(projectID);
      }
    });
  }

  // Method to set the personalDetailID and load details

  void setPersonalDetailID(String? id) {
    if (personalDetailID != id) {
      personalDetailID = id;
    }
  }

  void setProjectID(String? id) {
    if (projectID != id) {
      projectID = id;
    }
    if (projectID != null) {
      _loadProject();
    }
  }

  Future<void> _loadProject() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailID != null) {
      try {
        final data = await ProjectAPIService.getProject(token, projectID!);
        if (data != null) {
          final proj = ProjectModel.fromJson(data);
          if (mounted) {
            setState(() {
              project = proj.project ?? Project();
              _detailsLoaded = true;
            });
          }
        }
      } catch (e) {
        print('Failed to set project: $e');
      }
    }
  }
}
