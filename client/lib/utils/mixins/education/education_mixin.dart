import 'package:flutter/material.dart';
import 'package:resumecraft/api_services/education_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/education/read/education_model.dart';

mixin EducationMixin<T extends StatefulWidget> on State<T> {
  Education? education;
  String? educationID;
  String? personalDetailID;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Optionally, you might not call _loadEducation here if id is not set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final educationID = args?['educationID'] as String?;
      final personalDetailID = args?['personalDetailID'] as String?;

      setPersonalDetailID(personalDetailID);

      if (educationID != null && !_detailsLoaded) {
        setEducationlID(educationID);
      }
    });
  }

  // Method to set the personalDetailID and load details

  void setPersonalDetailID(String? id) {
    if (personalDetailID != id) {
      personalDetailID = id;
    }
  }

  void setEducationlID(String? id) {
    if (educationID != id) {
      educationID = id;
    }
    if (educationID != null) {
      _loadEducation();
    }
  }

  Future<void> _loadEducation() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && educationID != null) {
      try {
        final data =
            await EducationAPIService.getEducation(token, educationID!);
        if (data != null) {
          final edu = EducationModel.fromJson(data);
          if (mounted) {
            setState(() {
              education = edu.education ?? Education();
              _detailsLoaded = true;
            });
          }
        }
      } catch (e) {
        print('Failed to set education: $e');
      }
    }
  }
}
