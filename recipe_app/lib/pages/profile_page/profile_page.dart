import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Profile Page'),
      ),
      backgroundColor: Colors.green[200],
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Align(
            //Alignment for user profile picture. Contains a child the contains the elements to add a profile image
            alignment: Alignment(0.0, -0.8),
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.brown, // Placeholder for image
              foregroundImage:
                  AssetImage('assets/images/profile_page/demo_pic.jpeg'),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Stack(
            //This is the start of the Column that allows for multiple widgets to be added below the user profile picture
            children: [
              Column(
                //Column to control all Y axis of the widgets
                children: [
                  Row(
                    // Controls all X - axis of the username block
                    children: [
                      SizedBox(
                        //Pads the row away from the border
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Text('Username:', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        //adds spacing between username and the container for the data
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        //this is a black container, but will be able to load the username currently logged in from the database
                        color: Colors.lightBlue,
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ],
                  ),
                  //This the block under the username and allows for morre widgets to be added
                  SizedBox(
                    //This creats the spacing between username and email widgets
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    //This row controls the X - Axis and spacing of the email block
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Text('Email:', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        color: Colors.lightBlue,
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
