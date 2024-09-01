import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import 'package:resumecraft/api_services/skill_api_service.dart';
import 'package:resumecraft/utils/mixins/skill/skill_mixin.dart';
import 'package:resumecraft/models/profile_section/skills/write/skill_request_model.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';

import '../../../config.dart';

class SkillPage extends StatefulWidget {
  const SkillPage({super.key});

  @override
  State<SkillPage> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage>
    with UserProfileMixin, SkillMixin {
  final Color primaryColor = HexColor('#283B71');
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApicallProcess = false;
  String? skillName;
  String? skillPercentage;
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final personalDetailID = args?['personalDetailID'] as String?;
    final skillID = args?['skillID'] as String?;

    if (personalDetailID != null) {
      setPersonalDetailID(personalDetailID);
    }

    if (skillID != null) {
      setSkillID(skillID);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _skillUI(context),
    );
  }

  Widget _skillUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: globalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "skillName",
              "Skill Name",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Skill name cannot be empty';
                }
                return null;
              },
              (onSavedVal) {
                skillName = onSavedVal;
              },
              initialValue: skill?.skillName ?? "",
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
              "skillPercentage",
              "Skill Percentage",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Skills Percentage cannot be empty";
                }
                if (int.tryParse(onValidateVal) == null ||
                    int.parse(onValidateVal) < 0 ||
                    int.parse(onValidateVal) > 100) {
                  return 'Enter a valid percentage between 0 and 100';
                }
                return null;
              },
              (onSavedVal) {
                skillPercentage = onSavedVal;
              },
              initialValue: skill?.skillPercentage ?? "",
              borderFocusColor: primaryColor,
              borderColor: primaryColor,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              labelFontSize: 16,
              paddingLeft: 0,
              paddingRight: 0,
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
                      SkillRequestModel model = SkillRequestModel(
                        userdetail: personalDetailID,
                        skillName: skillName!,
                        skillPercentage: skillPercentage!,
                      );
                      if (skill != null) {
                        final response = await SkillAPIService.updateSkill(
                            model, userToken, skillID!);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 200) {
                          print(
                              'this is the update response here--------------------------->${response.statusCode}');
                          FormHelper.showSimpleAlertDialog(context,
                              Config.appName, "skill detail edited!", "OK", () {
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Failed to edit skill. Please try again.",
                              "OK",
                              () => Navigator.pop(context));
                        }
                      } else {
                        final response =
                            await SkillAPIService.createSkill(model, userToken);
                        setState(() {
                          isApicallProcess = false;
                        });
                        if (response.statusCode == 201) {
                          FormHelper.showSimpleAlertDialog(
                              context, Config.appName, "Skill Saved!", "OK",
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
                              "Failed to save Skill. Please try again.",
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

// Save Function Adjustment
  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
