import 'package:flutter/material.dart';

import 'package:resumecraft/api_services/education_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/education/read/educations_model.dart';

mixin EducationsMixin<T extends StatefulWidget> on State<T> {
  List<Educations> educations = [];
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
      loadEducations();
    }
  }

  Future<void> loadEducations() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty) {
      try {
        final data = await EducationAPIService.getEducationsByPersonalDetail(
            token, personalDetailID!);
        final eds = EducationsModel.fromJson(data);
        setState(() {
          educations = eds.educations ?? [];
        });
      } catch (e) {
        print('Failed to set educations: $e');
      }
    }
  }
}
