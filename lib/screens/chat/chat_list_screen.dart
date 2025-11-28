import 'package:flutter/material.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        'name': 'Sasha',
        'message': 'Mau diskusi lewat zoom?',
        'time': '7.30 PM',
        'unread': 1,
      },
      {
        'name': 'Juno',
        'message': 'Mau ketemu offline?',
        'time': '9.30 AM',
        'unread': 3,
      },
      {
        'name': 'Harya',
        'message': 'Gimana jadinya?',
        'time': '1.30 PM',
        'unread': 10,
      },
      {
        'name': 'Adlina',
        'message': 'Terima kasih kak! seru sekali!',
        'time': '5.40 PM',
        'unread': 0,
      },
      {
        'name': 'Lea',
        'message': 'Ok kak aman banget makasih ya',
        'time': '8.28 AM',
        'unread': 3,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFBFC9FF), // ungu muda
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFBFC9FF),
                Color(0xFFB3C4FF),
                Color(0xFFA2B5FF),
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Judul "Chat"
              const Text(
                'Chat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari chat',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // List chat
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return _ChatItem(
                        name: chat['name'] as String,
                        message: chat['message'] as String,
                        time: chat['time'] as String,
                        unread: chat['unread'] as int,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatRoomScreen(
                                tutorName: chat['name'] as String,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // NOTE: bottom navigation aslinya ada, tapi dihandle screen lain.
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unread;
  final VoidCallback onTap;

  const _ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6F2FF),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png', // ganti dengan foto tutor kalian
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Nama + message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF4B3C73),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Waktu + unread badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (unread > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6E8BFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        unread.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
