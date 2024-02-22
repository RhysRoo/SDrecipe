import 'package:flutter/material.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            _buildProfileImage(),
            const SizedBox(height: 40.0),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.15, // Adjust the height as needed
              width: MediaQuery.of(context).size.width * 0.7,
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInfoItem('Username:', 'JohnDoe'),
                      _buildInfoItem('Email:', 'johndoe@example.com'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.28, // Adjust the height as needed
              width: MediaQuery.of(context).size.width * 0.7,
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
                      _buildInfoItem('Age:', '25'),
                      _buildInfoItem('First Name:', 'John'),
                      _buildInfoItem('Last Name:', 'Doe'),
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

  Widget _buildInfoItem(String label, String value) {
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
            value,
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
            // Add functionality for deleting data
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
                      // Add custom validation rules for username
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
                      // Add custom validation rules for age
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
                      // Add custom validation rules for first name
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
                      // Add custom validation rules for last name
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Entry point
                  print('Correct Information');
                  Navigator.of(context).pop();
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
