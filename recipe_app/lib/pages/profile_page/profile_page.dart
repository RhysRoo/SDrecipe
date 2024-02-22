// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_log/pages/profile_page/profileManager.dart';
import 'package:flutter_log/pages/profile_page/userModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _foodRestictionController =
      TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProfileManager profileManager = ProfileManager();

  UserModel? currentUser; // Add a property to store the user data

  @override
  void initState() {
    super.initState();
    // Load user details when the page is initialized
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    try {
      Map<String, dynamic>? userData = await profileManager.getUserDetails();
      if (userData != null) {
        // Update the currentUser with the retrieved data
        setState(() {
          currentUser = UserModel(
            age: userData['age'] ?? '',
            username: userData['username'] ?? '',
            firstName: userData['firstName'] ?? '',
            lastName: userData['lastName'] ?? '',
            foodRestriction: userData['foodRestriction'] ?? '',
            bio: userData['bio'] ?? '',
          );
        });
      }
    } catch (e) {
      print("Error loading user details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Profile Page'),
      ),
      backgroundColor: Colors.green[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            _buildProfileImage(),
            const SizedBox(height: 40.0),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.2, // Adjust the height as needed
              width: MediaQuery.of(context).size.width * 0.6,
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInfoItem('Username:', 'username'),
                      _buildInfoItem('Food Restriction: ', 'foodRestriction')
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.28, // Adjust the height as needed
              width: MediaQuery.of(context).size.width * 0.6,
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildSectionTitle('User Information'),
                      _buildInfoItem('Age:', 'age'),
                      _buildInfoItem('First Name:', 'firstName'),
                      _buildInfoItem('Last Name:', 'lastName'),
                      _buildInfoItem('Bio:', 'bio'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return const Center(
      child: CircleAvatar(
        radius: 80,
        foregroundImage: AssetImage('assets/images/profile_page/demo_pic.jpeg'),
      ),
    );
  }

  // Update _buildInfoItem to handle null values
  Widget _buildInfoItem(String label, String key) {
    // Display the actual user data if available, otherwise display a "Loading..." placeholder
    String? displayValue = currentUser?.toJson()[key];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            displayValue ?? 'N/A', // Use 'N/A' if the value is null
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            _showDeleteConfirmationDialog();
          },
          child: const Text(
            'Delete Information',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _showChangeInformationForm();
          },
          child: const Text(
            'Change Information',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
              'Are you sure you want to delete your information? This action cannot be undone.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // User confirmed, proceed with deletion
                await profileManager.deleteUserDetails();
                _loadUserDetails(); // Automatically load updated user details
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showChangeInformationForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Information'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.length < 4) {
                        return 'Username must be at least 4 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an age';
                      }
                      if (!int.tryParse(value)!.isBetween(18, 99)) {
                        return 'Age must be between 18 and 99';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a first name';
                      }
                      if (value.length < 2) {
                        return 'First name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a last name';
                      }
                      if (value.length < 2) {
                        return 'Last name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _foodRestictionController,
                    decoration:
                        const InputDecoration(labelText: 'Food Restriction'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a last name';
                      }
                      if (value.length < 2) {
                        return 'Last name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'Bio'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a last name';
                      }
                      if (value.length < 2) {
                        return 'Last name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (_formKey.currentState?.validate() ?? false) {
                    print("Validation successful");

                    UserModel user = UserModel(
                      age: _ageController.text.trim(),
                      username: _usernameController.text.trim(),
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      foodRestriction: _foodRestictionController.text.trim(),
                      bio: _bioController.text.trim(),
                    );

                    // Save the user details
                    await profileManager.storeUserDetails(user);

                    // Automatically load updated user details
                    _loadUserDetails();

                    _ageController.clear();
                    _usernameController.clear();
                    _lastNameController.clear();
                    _firstNameController.clear();
                    _foodRestictionController.clear();
                    _bioController.clear();

                    Navigator.of(context).pop();
                  } else {
                    print("Validation failed");
                  }
                } catch (e) {
                  print("Error: $e");
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

extension IntExtension on int {
  // Helper extension to check if an integer is between two values
  bool isBetween(int lower, int upper) => this >= lower && this <= upper;
}
