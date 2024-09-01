import 'package:flutter/material.dart';
import 'package:resumecraft/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/api_services/education_api_service.dart';
import 'package:resumecraft/utils/mixins/education/education_mixin.dart';
import 'package:resumecraft/models/profile_section/education/write/education_request_model.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage>
    with UserProfileMixin, EducationMixin {
  final Color primaryColor = HexColor('#283B71');
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApicallProcess = false;
  String? course;
  String? university;
  String? gpa;
  DateTime? startDate;
  DateTime? endDate;

  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final personalDetailID = args?['personalDetailID'] as String?;
    final educationID = args?['educationID'] as String?;

    if (personalDetailID != null) {
      setPersonalDetailID(personalDetailID);
    }

    print(
        'personal detail id here------------------------------------>$personalDetailID');

    if (educationID != null) {
      setEducationlID(educationID);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _educationUI(context),
    );
  }

  Widget _educationUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: globalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "course",
              "Course",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Course cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                course = onSavedVal;
              },
              initialValue: education?.course ?? "",
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
              "university",
              "University",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'University cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                university = onSavedVal;
              },
              initialValue: education?.university ?? "",
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
              "gpa",
              "GPA",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "GPA cannot be empty";
                }
                if (double.tryParse(onValidateVal) == null ||
                    double.parse(onValidateVal) < 1.0 ||
                    double.parse(onValidateVal) > 4.0) {
                  return 'Enter a valid GPA between 1.00 and 4.00';
                }
                return null;
              },
              (onSavedVal) {
                gpa = onSavedVal;
              },
              initialValue: education?.gpa ?? "",
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
                    "Start Date", startDate ?? education?.startDate,
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
                  "End Date/Expected",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                _datePickerField("End Date", endDate ?? education?.endDate,
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
                      EducationRequestModel model = EducationRequestModel(
                          userdetail: personalDetailID,
                          course: course!,
                          university: university!,
                          gpa: gpa!,
                          startDate: startDate,
                          endDate: endDate);
                      if (education != null) {
                        final response =
                            await EducationAPIService.updateEducation(
                                model, userToken, educationID!);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 200) {
                          print(
                              'this is the update response here--------------------------->${response.statusCode}');
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "education detail edited!",
                              "OK", () {
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to edit education. Please try again.",
                              "OK",
                              () => Navigator.pop(context));
                        }
                      } else {
                        final response =
                            await EducationAPIService.createEducation(
                                model, userToken);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 201) {
                          FormHelper.showSimpleAlertDialog(
                              context, Config.appName, "Education Saved!", "OK",
                              () {
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          });
                        } else {
                          print(
                              'this is the create response here--------------------------->${response.statusCode}');
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to save Education. Please try again.",
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
      if (startDate == null && education != null) {
        startDate = education?.startDate;
      }

      if (endDate == null && education != null) {
        endDate = education?.endDate;
      }

      return true;
    } else {
      return false;
    }
  }
}
