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
            height: MediaQuery.of(context).size.height * 0.043,
          ),
          const Align(
            child: CircleAvatar(
              radius: 100,
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
                      const Text('Username:', style: TextStyle(fontSize: 20)),
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
                      const Text('Email:', style: TextStyle(fontSize: 20)),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Stack(
                children: [
                  Container(
                    //delete data button to delete app data
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.33,
                    color: Colors.grey,
                    child: MaterialButton(
                      onPressed: () {},
                      child: const Text(
                        'Delete Data',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Container(
                //delete data button to delete app data
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.44,
                color: Colors.grey,
                child: MaterialButton(
                  onPressed: () {},
                  child: const Text(
                    'Change Username',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            //This is the Y-Axis spacing between the User Information title abd the delete data and change username buttons
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              //This is a title for the user information, which the data below
              'User Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            //This is spacing for the title and the age Y-Axis
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(
            children: [
              SizedBox(
                //This is X-Axis spacing for the age text
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              const Text(
                  //This is the age text
                  'Age:',
                  style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(
            //This is Y-Axis spacing for Age and Weight
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            children: [
              SizedBox(
                //This is X-Axis spacing for the Weight Text
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const Text('Weight:', style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(
            //This is Y-Axis spacing for Age and Weight
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            children: [
              SizedBox(
                //X_Axis spacing for First Name
                width: MediaQuery.of(context).size.width * 0.13,
              ),
              Text(
                'First Name: ',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          SizedBox(
            //This is Y-Axis spacing for First Name and Last Name
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            children: [
              SizedBox(
                //X-Axis spacing for Surname
                width: MediaQuery.of(context).size.width * 0.18,
              ),
              Text(
                'Surname:',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
