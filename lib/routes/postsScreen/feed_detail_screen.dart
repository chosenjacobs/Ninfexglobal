import 'package:flutter/material.dart';

class FeedDetailScreen extends StatefulWidget {
  const FeedDetailScreen({super.key});

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _hasMoreComments = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoadingMore &&
        _hasMoreComments) {
      _loadMoreComments();
    }
  }

  Future<void> _loadMoreComments() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    // Simulate loading more comments
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoadingMore = false;
      // Set _hasMoreComments to false when there are no more comments to load
      // _hasMoreComments = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Post Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show post options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                // Post content
                _buildPostContent(),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Post stats
                _buildPostStats(),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Comments section
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Comments list
                ...List.generate(
                  20,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CommentTile(
                      username: 'User ${index + 1}',
                      comment: 'This is comment ${index + 1}. Comments can be multiple lines long and should wrap properly.',
                      timeAgo: '${index + 1}h ago',
                      likes: index * 2,
                      isLiked: index % 3 == 0,
                      onLike: () {
                        // Handle like
                      },
                      onReply: () {
                        // Handle reply
                      },
                    ),
                  ),
                ),

                // Loading indicator
                if (_isLoadingMore)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green[600]!,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildPostContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person),
          ),
          title: const Text(
            'John Doe',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '2 hours ago',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'This is a sample post content. It can be multiple lines long and contain detailed information about the topic being discussed.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildPostStats() {
    return Row(
      children: [
        Row(
          children: [
            Icon(Icons.thumb_up, size: 16, color: Colors.green[600]),
            const SizedBox(width: 4),
            Text(
              '124 likes',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            Icon(Icons.comment, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              '48 comments',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        8,
        16,
        8 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.green[600]),
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  // Handle comment submission
                  _commentController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  final String username;
  final String comment;
  final String timeAgo;
  final int likes;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onReply;

  const CommentTile({
    super.key,
    required this.username,
    required this.comment,
    required this.timeAgo,
    required this.likes,
    required this.isLiked,
    required this.onLike,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: 16,
          child: const Icon(Icons.person, size: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(comment),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Row(
                  children: [
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onLike,
                      child: Row(
                        children: [
                          Icon(
                            isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                            size: 14,
                            color: isLiked ? Colors.green[600] : Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            likes.toString(),
                            style: TextStyle(
                              color: isLiked ? Colors.green[600] : Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onReply,
                      child: Text(
                        'Reply',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
