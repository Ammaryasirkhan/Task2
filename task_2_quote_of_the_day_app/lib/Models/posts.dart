import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class Quote {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;

  const Quote({
    required this.description,
    required this.username,
    required this.uid,
    required this.postId,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'username': username,
        'postId': postId,
        'datePublished': datePublished,
      };

  static Quote fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Quote(
      description: snapshot['description'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
    );
  }
}
