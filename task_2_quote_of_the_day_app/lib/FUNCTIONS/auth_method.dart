import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Models/posts.dart';
import '../Models/user_model.dart' as model;
import 'storage_mthods.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    String response = "Some error happened";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(credential.user!.uid);

        model.User user = model.User(
          username: username,
          uid: credential.user!.uid,
          email: email,
        );
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        response = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'inavlid-email') {
        response = 'The email is badl formatted';
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String response = "Some error happened";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(credential.user!.uid);

        response = "success";
      } else {
        response = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found' || err.code == 'wrong-password') {
        response = 'Invalid email or password';
      } else if (err.code == 'invalid-email') {
        response = 'The email is badly formatted';
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
