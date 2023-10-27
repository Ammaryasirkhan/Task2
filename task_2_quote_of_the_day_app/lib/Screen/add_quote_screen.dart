import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../FUNCTIONS/auth_method.dart';
import '../Models/posts.dart';
import '../Providers/user_provider.dart';

class UploadQuotePage extends StatefulWidget {
  @override
  _UploadQuotePageState createState() => _UploadQuotePageState();
}

class _UploadQuotePageState extends State<UploadQuotePage> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _postQuote() async {
    if (_formKey.currentState!.validate()) {
      // Validate the form
      final text = _textController.text;
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final user = await Auth().getUserDetails(); // Fetch the user details
      final username = user.username;

      final postId = UniqueKey().toString();

      FirebaseFirestore.instance.collection('quotes').add(
            Quote(
              description: text,
              uid: uid,
              username: username,
              postId: postId, // You may set a postId if needed
              datePublished: DateTime.now(),
            ).toJson(),
          );
      _textController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quote posted successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Quote', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: _postQuote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'Enter your quote'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quote.';
                  }
                  return null;
                },
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
