import 'package:flutter/material.dart';
import 'package:resumecraft/api_services/experience_api_service.dart';
import 'package:resumecraft/utils/shared_prefs/user_shared_prefs.dart';
import 'package:resumecraft/models/profile_section/experience/read/experience_model.dart';

mixin ExperienceMixin<T extends StatefulWidget> on State<T> {
  Experience? experience;
  String? experienceID;
  String? personalDetailID;
  bool _detailsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Optionally, you might not call _loadEducation here if id is not set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final experienceID = args?['experienceID'] as String?;
      final personalDetailID = args?['personalDetailID'] as String?;

      setPersonalDetailID(personalDetailID);

      if (experienceID != null && !_detailsLoaded) {
        setExperienceID(experienceID);
      }
    });
  }

  // Method to set the personalDetailID and load details

  void setPersonalDetailID(String? id) {
    if (personalDetailID != id) {
      personalDetailID = id;
    }
  }

  void setExperienceID(String? id) {
    if (experienceID != id) {
      experienceID = id;
    }
    if (experienceID != null) {
      _loadExperience();
    }
  }

  Future<void> _loadExperience() async {
    if (_detailsLoaded) return;

    final prefs = await UserSharedPrefs.getLoginResponse();
    final token = prefs?.token ?? '';
    if (token.isNotEmpty && personalDetailID != null) {
      try {
        final data =
            await ExperienceAPIService.getExperience(token, experienceID!);
        if (data != null) {
          final exp = ExperienceModel.fromJson(data);
          if (mounted) {
            setState(() {
              experience = exp.experience ?? Experience();
              _detailsLoaded = true;
            });
          }
        }
      } catch (e) {
        print('Failed to set experience: $e');
      }
    }
  }
}
