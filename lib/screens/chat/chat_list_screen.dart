import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../supabase_client.dart';
import '../widgets/bottom_navbar.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getChats() async {
    if (currentUserId == null) return [];

    final threads = await supabase
        .from('threads')
        .select()
        .or('student_id.eq.$currentUserId,tutor_id.eq.$currentUserId')
        .order('last_message_time', ascending: false);

    List<Map<String, dynamic>> results = [];

    for (var t in threads) {
      final studentId = t['student_id'];
      final tutorId = t['tutor_id'];

      final bool isStudent = currentUserId == studentId;
      final partnerId = isStudent ? tutorId : studentId;

      // Ambil nama partner dari tabel users
      final partner = await supabase
          .from('users')
          .select('username')
          .eq('id', partnerId)
          .maybeSingle();

      final unread = isStudent
          ? (t['unread_count_student'] ?? 0)
          : (t['unread_count_tutor'] ?? 0);

      results.add({
        "thread_id": t['id'],
        "name": partner?['username'] ?? "User",
        "last_message": t['last_message'] ?? "",
        "time": t['last_message_time'],
        "unread": unread,
      });
    }

    return results;
  }

  String formatTime(String? iso) {
    if (iso == null) return "";
    final dt = DateTime.parse(iso);
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _header(),

          Expanded(
            child: FutureBuilder(
              future: getChats(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final chats = snap.data!;
                if (chats.isEmpty) {
                  return Center(
                    child: Text("Belum ada chat",
                        style: GoogleFonts.poppins(fontSize: 14)),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: chats.length,
                  itemBuilder: (c, i) {
                    final chat = chats[i];
                    return _ChatTile(
                      name: chat['name'],
                      message: chat['last_message'],
                      time: formatTime(chat['time']),
                      unread: chat['unread'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatRoomScreen(
                              tutorName: chat['name'],
                              threadId: chat['thread_id'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),

      bottomNavigationBar: TutorBottomNavBar(
        currentIndex: 1,
        onTap: (i) {},
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      height: 150,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFBCC6F6), Color(0xFF566CD8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                "Chat",
                style: GoogleFonts.poppins(
                    fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              _searchBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Cari chat...",
              border: InputBorder.none),
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final String name, message, time;
  final int unread;
  final VoidCallback onTap;

  const _ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFE9EDFF),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                Text(time,
                    style:
                        GoogleFonts.poppins(fontSize: 11, color: Colors.black45)),
                const SizedBox(height: 6),

                if (unread > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF8FA8FF),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unread.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
