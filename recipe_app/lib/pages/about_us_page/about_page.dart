import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_log/pages/faqs_page/FAQ_page.dart';
import 'package:flutter_log/pages/profile_page/profile_page.dart';
import 'package:flutter_log/pages/ratings_page/rating_page.dart';
import 'package:flutter_log/pages/recipe_generation_page/generation_page.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);


  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign out the user
  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      // Navigate to the login screen or any other screen after signing out
      // Example: Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // Method to launch email app
  void _launchEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'up2120303@myport.ac.uk',
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      print('Could not launch email');
    }
  }


void _launchEmail2() async {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'up2138017@myport.ac.uk',
  );
  if (await canLaunch(_emailLaunchUri.toString())) {
    await launch(_emailLaunchUri.toString());
  } else {
    print('Could not launch email');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(fontSize: 45)),
        backgroundColor: Colors.lightGreen[900],
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        shape: Border.all(strokeAlign: BorderSide.strokeAlignOutside),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: const DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    Text('Home Page', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Icon(Icons.info, size: 30),
                  ],
                ),
              ),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    const Text('User Profile', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Icon(Icons.person, size: 30),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    const Text('Generate Recipe',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Icon(Icons.generating_tokens, size: 35),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GenerationPage()));
              },
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    const Text('Add Recipe', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Icon(Icons.add, size: 30),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RatingPage()));
              },
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    const Text('FAQ', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Icon(Icons.question_answer, size: 30),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FAQ_Page()));
              },
            ),
            ListTile(
              title: Container(
                child: Row(
                  children: [
                    const Text('Log Out', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Icon(Icons.logout, size: 30),
                  ],
                ),
              ),
              onTap: () {
                _signOut();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[200],
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.009),
              Container(
                // Ui Panel
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.teal[600],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    'Sustainability is an exciting new application designed to help cut down on food waste. In the United Kingdom, approximately 9.5 million tonnes of food go to waste each year, a staggering amount. Meanwhile, 8.4 million people in the UK struggle with food poverty. It’s a heartbreaking paradox: while so much food is discarded, many individuals and families are left without enough to eat.\n\n'
                    'Our aim is to significantly reduce the amount of food waste being produced. This is beneficial to both the environment and saving money.\n\n'
                    'Less wasted food means fewer resources used in production. Further environmental benefits include reducing Greenhouse Gas Emissions, Rotting food in landfills produces methane, a potent greenhouse gas. Cutting waste helps mitigate climate change. Wasting less food means more money in our pockets.\n\n'
                    'The WasteAway application allows you to enter ingredients that you need to use before their “use by date” expires. Simply enter the ingredients you have into the App and you will be guided to exciting recipes that use what you have available. No more chucking out that “half a pineapple” or “pack of cream cheese”. This is the App that every household needs.',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 16),

                  // Add the red containers here
                 
                 
                 
  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.lightGreen[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/about_page/lil_tjay.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
            child: Text(
              'Josh Varney',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
            child: GestureDetector(
              onTap: _launchEmail2,
              child: Text(
                'Contact by email',
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    ),
    SizedBox(width: 20),
    Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.lightGreen[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/about_page/lil_tjay.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
            child: Text(
              'Hazaloid Jenkins',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
            child: GestureDetector(
              onTap: _launchEmail,
              child: Text(
                'Contact by email',
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
),





                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 20,
            child: InkWell(
              onTap: _launchEmail,
              child: Text(
                'Contact us via email',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
