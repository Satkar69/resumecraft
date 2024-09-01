import 'package:flutter/material.dart';
import 'package:resumecraft/config.dart';
import 'package:resumecraft/models/delete/delete_model.dart';
import 'package:resumecraft/api_services/personal_detail_api_service.dart';
import 'package:resumecraft/utils/mixins/user/user_mixin.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:resumecraft/utils/mixins/personal_detail/personal_details_mixin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with UserProfileMixin, PersonalDetailsMixin {
  final Color primaryColor = HexColor('#283B71');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Choose Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (personalDetails.isNotEmpty)
              ...personalDetails.map((personalDetail) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        backgroundImage: personalDetail.image != null &&
                                personalDetail.image!.isNotEmpty
                            ? NetworkImage(
                                '${Config.getProfileImage}${personalDetail.image}')
                            : null,
                        child: personalDetail.image == null ||
                                personalDetail.image!.isEmpty
                            ? const Icon(Icons.account_circle,
                                color: Colors.white)
                            : null,
                      ),
                      title: Text(personalDetail.fullname ?? 'No Name'),
                      subtitle: Text(personalDetail.email ?? 'No Email'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showConfirmDeleteDialog(personalDetail.id!);
                        },
                      ),
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/profile-section',
                          arguments: {
                            'personalDetailID': personalDetail.id,
                          },
                        );
                        if (result == true) {
                          setState(() {
                            loadPersonalDetails();
                          });
                        }
                      },
                    ),
                  ),
                );
              })
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No profiles available. Please create a new profile.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                child: const Text('+ Create New Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () async {
                  final result =
                      await Navigator.pushNamed(context, '/personal-detail');
                  if (result == true) {
                    setState(() {
                      loadPersonalDetails();
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmDeleteDialog(String personalDetailId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this profile?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the confirmation dialog

                // Perform delete operation
                try {
                  final response =
                      await PersonalDetailAPIService.deletePersonalDetail(
                    DeleteModel(
                      status: 'success',
                      statusCode: 200,
                      message: 'profile delete success',
                    ),
                    userToken,
                    personalDetailId,
                  );

                  if (mounted) {
                    if (response.statusCode == 200) {
                      _showResultDialog(response.message!);
                      setState(() {
                        loadPersonalDetails();
                      });
                    } else {
                      _showResultDialog("Unable to delete this profile");
                    }
                  }
                } catch (e) {
                  // Handle error and show result dialog if widget is still mounted
                  if (mounted) {
                    _showResultDialog("An error occurred: ${e.toString()}");
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the result dialog
              },
            ),
          ],
        );
      },
    );
  }
}
