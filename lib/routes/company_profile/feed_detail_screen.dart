import 'package:flutter/material.dart';

class FeedDetailScreen extends StatelessWidget {
  final String companyName;
  final String timeAgo;
  final String content;
  final int likes;
  final int comments;

  const FeedDetailScreen({
    super.key,
    required this.companyName,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        title: const Text(
          'Post Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.business),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Handle more options
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.thumb_up_outlined, 
                size: 20, 
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                '$likes',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 24),
              Icon(Icons.comment_outlined, 
                size: 20, 
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                '$comments',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 