import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screen/add_quote_screen.dart';
import '../Screen/profile_screen.dart';
import '../Screen/qote_display.dart';

List<Widget> homeScreenItems = [
  QuoteListPage(),
  UploadQuotePage(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
