import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_2_quote_of_the_day_app/Utilities/dimensions.dart';
import '../Utilities/show_snack_bar.dart'; // Import your utility for showing snackbar

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  bool isLoading = false;
  List<String> postedQuotes = [];
  List<String> savedQuotes = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var profileSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = profileSnap.data()!;

      // Fetch quotes posted by the user
      final postQuotesSnapshot = await FirebaseFirestore.instance
          .collection('quotes')
          .where('uid', isEqualTo: widget.uid)
          .get();
      postedQuotes = postQuotesSnapshot.docs
          .map((doc) => doc['description'] as String)
          .toList();

      // Fetch quotes saved by the user
      final savedQuotesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('saved_quotes')
          .get();
      savedQuotes = savedQuotesSnapshot.docs
          .map((doc) => doc['description'] as String)
          .toList();
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  // Function to sign out the user
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(
          context); // Navigate back to the previous screen or you can redirect to the login screen.
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dimensions.height15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: Dimensions.height50,
                          backgroundImage: AssetImage('assets/logo.png'),
                        ),
                        SizedBox(height: Dimensions.height20),
                        Text(
                          'Name: ${userData['username']}',
                          style: TextStyle(
                            fontSize: Dimensions.text20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Email: ${userData['email']}',
                          style: TextStyle(
                            fontSize: Dimensions.text16,
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        ElevatedButton(
                          onPressed: _signOut,
                          child: Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.height15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quotes Posted by You',
                          style: TextStyle(
                            fontSize: Dimensions.text20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.height15),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: postedQuotes.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4,
                              margin: EdgeInsets.all(Dimensions.height10),
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.height10),
                                child: Text(postedQuotes[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.height15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quotes Saved by You',
                          style: TextStyle(
                            fontSize: Dimensions.text20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.height10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: savedQuotes.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4,
                              margin: EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(savedQuotes[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
