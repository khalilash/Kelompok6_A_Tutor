import 'package:supabase_flutter/supabase_flutter.dart';

// client utama Supabase yang dipakai di seluruh app
final SupabaseClient supabase = Supabase.instance.client;

// optional: simpan id user yang sedang login
String? currentUserId;
