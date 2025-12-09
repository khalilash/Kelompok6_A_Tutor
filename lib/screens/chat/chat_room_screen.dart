import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../supabase_client.dart';

class ChatRoomScreen extends StatefulWidget {
  final String tutorName;
  final String threadId;

  const ChatRoomScreen({
    super.key,
    required this.tutorName,
    required this.threadId,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> messages = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadMessages();
    subscribeRealtime();
    markAsRead();
  }

  // ---------------------- LOAD MESSAGES ----------------------
  Future<void> loadMessages() async {
    final data = await supabase
        .from('messages')
        .select()
        .eq('thread_id', widget.threadId)
        .order('created_at', ascending: true);

    setState(() => messages = data);
  }

  // ---------------------- REALTIME LISTENER ----------------------
  void subscribeRealtime() {
    final channel = supabase.channel('chat-${widget.threadId}');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'thread_id',
        value: widget.threadId,
      ),
      callback: (_) => loadMessages(),
    );

    channel.onPostgresChanges(
      event: PostgresChangeEvent.update,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'thread_id',
        value: widget.threadId,
      ),
      callback: (_) => loadMessages(),
    );

    channel.onPostgresChanges(
      event: PostgresChangeEvent.delete,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'thread_id',
        value: widget.threadId,
      ),
      callback: (_) => loadMessages(),
    );

    channel.subscribe();
  }

  // ---------------------- MARK AS READ ----------------------
  Future<void> markAsRead() async {
    final thread = await supabase
        .from('threads')
        .select()
        .eq('id', widget.threadId)
        .maybeSingle();

    if (thread == null) return;

    final isStudent = currentUserId == thread['student_id'];

    await supabase
        .from('messages')
        .update({'is_read': true})
        .eq('thread_id', widget.threadId)
        .neq('sender_id', currentUserId!);

    await supabase.from('threads').update({
      if (isStudent) 'unread_count_student': 0 else 'unread_count_tutor': 0
    }).eq('id', widget.threadId);
  }

  // ---------------------- SEND MESSAGE ----------------------
  Future<void> sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    controller.clear();

    final thread = await supabase
        .from('threads')
        .select()
        .eq('id', widget.threadId)
        .maybeSingle();

    if (thread == null) return;

    final isStudent = currentUserId == thread['student_id'];

    await supabase.from('messages').insert({
      'thread_id': widget.threadId,
      'sender_id': currentUserId,
      'content': text,
      'is_removed': false,
    });

    await supabase.from('threads').update({
      'last_message': text,
      'last_message_time': DateTime.now().toIso8601String(),
      if (isStudent)
        'unread_count_tutor': (thread['unread_count_tutor'] ?? 0) + 1
      else
        'unread_count_student': (thread['unread_count_student'] ?? 0) + 1
    }).eq('id', widget.threadId);
  }

  // ---------------------- DELETE MESSAGE (SOFT DELETE) ----------------------
  Future<void> deleteMessage(String messageId) async {
    await supabase.from('messages').update({
      'is_removed': true,
      'content': 'Pesan telah dihapus',
    }).eq('id', messageId);

    await loadMessages();
  }

  // ---------------------- FORMAT TIME ----------------------
  String formatTime(String iso) {
    final DateTime t = DateTime.parse(iso);
    return "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
  }

  // ---------------------- BUILD UI ----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          header(),
          chatList(),
          inputBar(),
        ],
      ),
    );
  }

  // ---------------------- HEADER ----------------------
  Widget header() {
    return Material(
      elevation: 5,
      child: Container(
        color: const Color(0xFFB8C1F0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/logo.png'),
              ),
              const SizedBox(width: 8),
              Text(
                widget.tutorName,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------- CHAT LIST ----------------------
  Widget chatList() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_tutor.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: messages.length,
          itemBuilder: (c, i) {
            final msg = messages[i];
            final bool isMe = msg['sender_id'] == currentUserId;
            final bool isRead = msg['is_read'] ?? false;
            final bool isRemoved = msg['is_removed'] ?? false;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: GestureDetector(
                onLongPress: isRemoved
                    ? null
                    : () {
                        if (isMe) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Hapus pesan?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    deleteMessage(msg['id']);
                                  },
                                  child: const Text("Hapus"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isRemoved
                            ? Colors.grey.shade300
                            : isMe
                                ? const Color(0xFFFEB8C3)
                                : const Color.fromARGB(255, 119, 142, 255),

                        borderRadius: BorderRadius.circular(16),

                        // ⭐⭐⭐ SHADOW BUBBLE CHAT ⭐⭐⭐
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Text(
                        msg['content'] ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontStyle:
                              isRemoved ? FontStyle.italic : FontStyle.normal,
                          color: isRemoved ? Colors.black54 : Colors.black,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formatTime(msg['created_at']),
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                        if (isMe)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              isRead ? Icons.done_all : Icons.check,
                              size: 14,
                              color: isRead
                                  ? const Color.fromARGB(255, 0, 70, 128)
                                  : Colors.grey,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------------- INPUT BAR ----------------------
  Widget inputBar() {
    return Container(
      color: const Color(0xFFBCC6F6).withOpacity(0.6),
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.add, color: Colors.deepPurple.shade700),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Tulis pesan...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
