import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_navbar.dart';

// GSM TUTOR Colors
class GsmColors {
  static const Color orangeDark = Color(0xFFD65609);
  static const Color orangeLight = Color(0xFFFFA975);

  static const Color purpleDark = Color(0xFF566CD8);
  static const Color purpleLight = Color(0xFFBCC6F6);

  static const Color pinkDark = Color(0xFFFFACB9);
  static const Color pinkLight = Color(0xFFFEB8C3);

  static const Color textPink = Color(0xFFFF687F);
  static const Color textPurple = Color(0xFF566CD8);
  static const Color textOrange = Color(0xFFD65609);
}

class ChatRoomScreen extends StatelessWidget {
  final String tutorName;

  const ChatRoomScreen({
    super.key,
    required this.tutorName,
  });

  @override
  Widget build(BuildContext context) {
    final List<ChatMessage> messages = [
      ChatMessage(
        fromMe: true,
        text:
          'Halo kak Adlina! salam kenal 😊\nAku mau belajar pemrograman web, masih bisa ya?',
      ),
      ChatMessage(
        fromMe: false,
        text: 'Haii! Halo juga 🥰\nMasih bisa dong, kebetulan aku masih ada slot kosong.',
      ),
      ChatMessage(
        fromMe: true,
        text:
            'Yeyy syukurlah 😆\nKak, biasanya jadwal yang available di hari apa ya?',
      ),
      ChatMessage(
        fromMe: false,
        text:
            'Untuk minggu ini aku available hari Senin, Kamis, dan Sabtu ya.\nKakak minat yang jam berapa?',
      ),
      ChatMessage(
        fromMe: true,
        text: 'Kayaknya Kamis sore cocok kak, sekitar jam 4 boleh?',
      ),
      ChatMessage(
        fromMe: false,
        text:
            'Bisa banget 😊\nNanti aku jadwalkan ya hari Kamis jam 16.00.',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                GsmColors.purpleLight,
                GsmColors.purpleDark,
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
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/logo.png',
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
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'PWEB',
                          style: GoogleFonts.poppins(
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
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Today',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: GsmColors.textPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Chat list
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return _ChatBubble(message: msg);
                    },
                  ),
                ),
              ),

              // Input bar
              const _ChatInputBar(),
            ],
          ),
        ),
      ),

      // NAVBAR GLOBAL
      bottomNavigationBar: TutorBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // di ChatRoom, biarkan nav bar yang handle home/chat
        },
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: GsmColors.purpleLight,
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png',
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
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: GsmColors.textPurple,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'PWEB',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Detail Pesanan:',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '4 August 2025, 02.00–02.50\n'
                  '15 Mei 2025, 01.00–01.50',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.close, size: 18, color: Colors.grey),
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
    final bool isMe = message.fromMe;

    final Color bgColor = isMe
        ? GsmColors.pinkLight
        : GsmColors.purpleLight;
    final Alignment align =
        isMe ? Alignment.centerRight : Alignment.centerLeft;

    final BorderRadius radius = BorderRadius.only(
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
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GsmColors.purpleLight.withOpacity(0.6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add, color: GsmColors.purpleDark),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Tulis pesan...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ),
    );
  }
}
