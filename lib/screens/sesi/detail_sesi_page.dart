import 'package:flutter/material.dart';

class DetailSesiPage extends StatefulWidget {
  const DetailSesiPage({super.key});

  @override
  State<DetailSesiPage> createState() => _DetailSesiPageState();
}

class _DetailSesiPageState extends State<DetailSesiPage> {
  bool downloaded = false;
  bool hasRecording = false;
  int rating = 4;
  bool sesiSelesai = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map<String, dynamic>) {
      if (args['hasRecording'] == true) hasRecording = true;
      if (args['sesiSelesai'] == true) sesiSelesai = true;
      if (args['ratingAwal'] != null) rating = args['ratingAwal'];
      setState(() {});
    }
  }

  void _doDownload() async {
    setState(() => downloaded = true);
    await Navigator.pushNamed(context, '/downloadSuccess');
  }

  Widget _buildStar(int index) {
    return IconButton(
      onPressed: sesiSelesai ? () => setState(() => rating = index) : null,
      icon: Icon(
        index <= rating ? Icons.star : Icons.star_border,
        color: index <= rating
            ? const Color.fromARGB(255, 255, 247, 7)
            : const Color.fromARGB(255, 255, 255, 255),
      ),
      iconSize: 28,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // supaya background gambar tembus ke belakang AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/homepage',
            (route) => false,
          );
        },
      ),
        title: const Text('Detail Sesi'),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          // BACKGROUND GAMBAR DI ATAS
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220,
            child: Image.asset("assets/bgsesi.png", fit: BoxFit.cover),
          ),

          //  CONTAINER PUTIH BESAR UNTUK KONTEN
          Positioned.fill(
            top: 85, // tinggi overlap
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CONTAINER PROFIL TUTOR GRADIENT
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/bgpink.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 36,
                              backgroundImage: AssetImage(
                                "assets/tutorsesi.png",
                              ),
                              backgroundColor: Colors.white, // <-- latar putih
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Khalila',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Dosen Pemrograman',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Rp50.000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'ONLINE',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Text(
                              "Rating:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: List.generate(
                                5,
                                (i) => _buildStar(i + 1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '($rating)',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  //  MATERI
                  const Text(
                    "Sesi yang Akan Datang",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Pertemuan 1 Object Oriented Programming",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),

                  const Text(
                    "4 Agustus 2024",
                    style: TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "16.00-16.50 WIB",
                    style: TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 4),

                  Container(
                    width: double.infinity,
                    height: 3,
                    color: const Color.fromARGB(
                      255,
                      183,
                      212,
                      235,
                    ), // Warna garis
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "OOP Java (Object-Oriented Programming in Java) adalah paradigma pemrograman.",
                    style: TextStyle(color: Colors.black87),
                  ),

                  const SizedBox(height: 16),

                  //  TOMBOL DOWNLOAD DI LUAR CONTAINER PROFIL
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/bgoren.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.menu_book_outlined),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Materi Java Object Oriented Programming',
                          ),
                        ),
                        IconButton(
                          onPressed: downloaded ? null : _doDownload,
                          icon: Icon(
                            downloaded
                                ? Icons.check_circle
                                : Icons.download_outlined,
                            color: downloaded ? Colors.green : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  if (hasRecording)
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bgbiru.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_circle_fill,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text('Rekaman Sesi Tutor tersedia'),
                          ),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Memutar rekaman (mock)'),
                                ),
                              );
                            },
                            child: const Text("Putar"),
                          ),
                        ],
                      ),
                    ),

                  const Spacer(),

                  //  TOMBOL GABUNG SESI DI BAGIAN PALING BAWAH
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBCC6F6),
                        foregroundColor: Colors.white, // warna teks
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/popupBelumDimulai'),
                      child: const Text('GABUNG SESI'),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}