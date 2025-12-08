import 'package:flutter/material.dart';
import '../../supabase_client.dart';

class UsersDebugPage extends StatefulWidget {
  const UsersDebugPage({super.key});

  @override
  State<UsersDebugPage> createState() => _UsersDebugPageState();
}

class _UsersDebugPageState extends State<UsersDebugPage> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
    final data = await supabase.from('users').select().order('created_at');


      setState(() {
        _users = List<Map<String, dynamic>>.from(data);
        _isLoading = false;
      });

      // cek di console
      // ignore: avoid_print
      print('DATA USERS: $_users');
    } catch (e) {
      // ignore: avoid_print
      print('ERROR SUPABASE: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users Debug')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
              ? const Center(child: Text('Belum ada data users'))
              : ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final u = _users[index];
                    return ListTile(
                      title: Text(u['username'] ?? '-'),
                      subtitle: Text(u['email'] ?? '-'),
                    );
                  },
                ),
    );
  }
}
