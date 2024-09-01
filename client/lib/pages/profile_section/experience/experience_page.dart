import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/api_services/experience_api_service.dart';
import 'package:resumecraft/utils/mixins/experience/experience_mixin.dart';
import 'package:resumecraft/models/profile_section/experience/write/experience_request_model.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';

import '../../../config.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage>
    with UserProfileMixin, ExperienceMixin {
  final Color primaryColor = HexColor('#283B71');
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApicallProcess = false;
  String? companyName;
  String? jobTitle;
  String? details;
  DateTime? startDate;
  DateTime? endDate;

  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final personalDetailID = args?['personalDetailID'] as String?;
    final experienceID = args?['experienceID'] as String?;

    if (personalDetailID != null) {
      setPersonalDetailID(personalDetailID);
    }

    if (experienceID != null) {
      setExperienceID(experienceID);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experience', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _experienceUI(context),
    );
  }

  Widget _experienceUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: globalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "companyName",
              "Company Name",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Company Name cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                companyName = onSavedVal;
              },
              initialValue: experience?.companyName ?? "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              labelFontSize: 16,
              paddingLeft: 0,
              paddingRight: 0,
            ),
            const SizedBox(height: 16),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "jobTitle",
              "Job Title",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Job Title cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                jobTitle = onSavedVal;
              },
              initialValue: experience?.jobTitle ?? "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              labelFontSize: 16,
              paddingLeft: 0,
              paddingRight: 0,
            ),
            const SizedBox(height: 16),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "details",
              "Details",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Details cannot be empty";
                }
                return null;
              },
              (onSavedVal) {
                details = onSavedVal;
              },
              initialValue: experience?.details ?? "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              labelFontSize: 16,
              paddingLeft: 0,
              paddingRight: 0,
            ),
            const SizedBox(height: 16),
            // Start Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Start Date",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                _datePickerField(
                    "Start Date", startDate ?? experience?.startDate,
                    (selectedDate) {
                  setState(() {
                    startDate = selectedDate;
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),
            // End Date/Expected
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "End Date",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                _datePickerField("End Date", endDate ?? experience?.endDate,
                    (selectedDate) {
                  setState(() {
                    endDate = selectedDate;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: FormHelper.submitButton(
                "Save",
                () async {
                  if (validateAndSave()) {
                    setState(() {
                      isApicallProcess = true;
                    });

                    try {
                      ExperienceRequestModel model = ExperienceRequestModel(
                        userdetail: personalDetailID,
                        companyName: companyName!,
                        jobTitle: jobTitle!,
                        startDate: startDate,
                        endDate: endDate,
                        details: details!,
                      );
                      if (experience != null) {
                        final response =
                            await ExperienceAPIService.updateExperience(
                                model, userToken, experienceID!);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 200) {
                          print(
                              'this is the update response here--------------------------->${response.statusCode}');
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "experience detail edited!",
                              "OK", () {
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to edit experience. Please try again.",
                              "OK",
                              () => Navigator.pop(context));
                        }
                      } else {
                        final response =
                            await ExperienceAPIService.createExperience(
                                model, userToken);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 201) {
                          FormHelper.showSimpleAlertDialog(context,
                              Config.appName, "Experience Saved!", "OK", () {
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          });
                        } else {
                          print(
                              'this is the create response here--------------------------->${response.statusCode}');
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to save Experience. Please try again.",
                              "OK",
                              () => Navigator.pop(context));
                        }
                      }
                    } catch (e) {
                      setState(() {
                        isApicallProcess = false;
                      });
                      FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "An error occurred. Please try again.",
                          "OK",
                          () => Navigator.pop(context));
                    }
                  }
                  setState(() {
                    isApicallProcess = false;
                  });
                },
                btnColor: Colors.green,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Date Picker Field Update
  Widget _datePickerField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null) {
          onDateSelected(selectedDate);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null
                  ? "${date.toLocal()}".split(' ')[0]
                  : "Select $label",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const Icon(Icons.calendar_today, color: Colors.black54),
          ],
        ),
      ),
    );
  }

// Save Function Adjustment
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();

      // Retain original start and end dates if not modified
      if (startDate == null && experience != null) {
        startDate = experience?.startDate;
      }

      if (endDate == null && experience != null) {
        endDate = experience?.endDate;
      }

      return true;
    } else {
      return false;
    }
  }
}
