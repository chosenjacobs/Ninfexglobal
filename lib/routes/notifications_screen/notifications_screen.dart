import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle mark all as read
            },
            child: const Text(
              'Mark all as read',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          // Alternate between different notification types
          final notificationType = index % 4;
          return _NotificationItem(
            type: notificationType,
            isUnread: index < 3,
            time: '${index + 1}h ago',
          );
        },
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final int type;
  final bool isUnread;
  final String time;

  const _NotificationItem({
    required this.type,
    required this.isUnread,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isUnread ? Colors.green[50] : Colors.transparent,
      child: InkWell(
        onTap: () {
          // Handle notification tap based on type
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isUnread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData icon;
    Color? color;

    switch (type) {
      case 0: // Message
        icon = Icons.message;
        color = Colors.blue[600];
        break;
      case 1: // Like
        icon = Icons.favorite;
        color = Colors.red[600];
        break;
      case 2: // Follow
        icon = Icons.person_add;
        color = Colors.green[600];
        break;
      default: // Comment
        icon = Icons.comment;
        color = Colors.orange[600];
        break;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color?.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 24,
        color: color,
      ),
    );
  }

  Widget _buildTitle() {
    String title;
    switch (type) {
      case 0:
        title = 'Company ABC sent you a message';
        break;
      case 1:
        title = 'Company XYZ liked your post';
        break;
      case 2:
        title = 'Company DEF started following you';
        break;
      default:
        title = 'Company GHI commented on your post';
        break;
    }

    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[800],
        height: 1.4,
      ),
    );
  }
}
