import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_2_quote_of_the_day_app/Utilities/colors.dart';
import 'package:task_2_quote_of_the_day_app/Utilities/dimensions.dart';

class QuoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote List', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('quotes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final quotes = snapshot.data!.docs;

          if (quotes.isEmpty) {
            return Center(
              child: Text('No quotes available.'),
            );
          }

          return ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              final quoteData = quotes[index].data() as Map<String, dynamic>;
              final quoteId = quotes[index].id;

              return QuoteItem(
                description: quoteData['description'],
                username: quoteData['username'],
                datePublished: quoteData['datePublished'],
                isBookmarked: false, // Initially, the quote is not bookmarked
                onBookmark: (isBookmarked) {
                  toggleBookmark(quoteId, isBookmarked);
                },
              );
            },
          );
        },
      ),
    );
  }

  void toggleBookmark(String quoteId, bool isBookmarked) {
    // Implement the bookmark functionality here.
    // You can update Firestore to store the user's saved quotes.
  }
}

class QuoteItem extends StatefulWidget {
  final String description;
  final String username;
  final Timestamp datePublished;
  final bool isBookmarked;
  final ValueChanged<bool> onBookmark;

  const QuoteItem({
    required this.description,
    required this.username,
    required this.datePublished,
    required this.isBookmarked,
    required this.onBookmark,
  });

  @override
  _QuoteItemState createState() => _QuoteItemState();
}

class _QuoteItemState extends State<QuoteItem> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.height15),
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.height10, horizontal: Dimensions.height5),
      decoration: BoxDecoration(
        color: ColorRes.app.withOpacity(0.5),
        borderRadius: BorderRadius.circular(Dimensions.height10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.description),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Posted by: ${widget.username}'),
              Text(
                'Date: ${_formatDate(widget.datePublished)}',
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: isBookmarked ? ColorRes.app : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                  widget.onBookmark(isBookmarked);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(Timestamp date) {
    final dateTime = date.toDate();
    final formatter = DateFormat('MMM d, y HH:mm a');
    return formatter.format(dateTime);
  }
}
