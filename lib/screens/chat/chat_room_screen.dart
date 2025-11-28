import 'package:flutter/material.dart';

class ChatRoomScreen extends StatelessWidget {
  final String tutorName;

  const ChatRoomScreen({
    super.key,
    required this.tutorName,
  });

  @override
  Widget build(BuildContext context) {
    // dummy pesan
    final messages = [
      ChatMessage(
        fromMe: false,
        text:
            'Halooo kak salam kenal aku Lila, aku butuh tutor buat pemrograman web, bisa gaa?',
      ),
      ChatMessage(
        fromMe: true,
        text: 'Halo Lila! salam juga 🥰',
      ),
      ChatMessage(
        fromMe: true,
        text:
            'Kamu butuh untuk kapan?\nUntuk beberapa hari ke depan sesi turtorku masih banyak yang kosong sih, dicek ajaa',
      ),
      ChatMessage(
        fromMe: false,
        text:
            'Oke kak, nanti aku request buat diajarin pelan-pelan ya pake bahasa bayi…',
      ),
      ChatMessage(
        fromMe: true,
        text: 'Wkwkw, oke Lila!',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFBFC9FF),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFBFC9FF),
                Color(0xFFA4B8FF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // AppBar custom
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/logo.png', // ganti sesuai asset
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tutorName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'PWEB',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.more_vert, color: Colors.white),
                  ],
                ),
              ),

              // Detail Pesanan + label "Today"
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailOrderCard(tutorName: tutorName),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4B3C73),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Chat list
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return _ChatBubble(message: msg);
                  },
                ),
              ),

              // Input bar
              const _ChatInputBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailOrderCard extends StatelessWidget {
  final String tutorName;

  const DetailOrderCard({super.key, required this.tutorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F2FF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png', // ganti
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tutorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B3C73),
                  ),
                ),
                const Text(
                  'PWEB',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Detail Pesanan:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '4 August 2025, 02.00–02.50\n'
                  '15 Mei 2025, 01.00–01.50',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.close, size: 18),
        ],
      ),
    );
  }
}

class ChatMessage {
  final bool fromMe;
  final String text;

  ChatMessage({required this.fromMe, required this.text});
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.fromMe;

    final bgColor =
        isMe ? const Color(0xFFFFC5E0) : const Color(0xFFE0F0FF); // pink / biru
    final align =
        isMe ? Alignment.centerRight : Alignment.centerLeft;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft:
          isMe ? const Radius.circular(18) : const Radius.circular(4),
      bottomRight:
          isMe ? const Radius.circular(4) : const Radius.circular(18),
    );

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: radius,
        ),
        child: Text(
          message.text,
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE6E7FF),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Tulis pesan...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
