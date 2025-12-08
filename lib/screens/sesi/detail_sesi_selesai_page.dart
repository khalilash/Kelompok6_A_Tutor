import 'package:flutter/material.dart';


class DetailSesiSelesaiPage extends StatefulWidget {
  const DetailSesiSelesaiPage({super.key});


  @override
  State<DetailSesiSelesaiPage> createState() => _DetailSesiSelesaiPageState();
}


class _DetailSesiSelesaiPageState extends State<DetailSesiSelesaiPage> {
  bool downloadedRecording = false;
  int rating = 0;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;


    if (args is Map<String, dynamic>) {
      rating = args["rating"] ?? 0;
    }
  }


  void _downloadRecording() async {
    setState(() => downloadedRecording = true);


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Rekaman berhasil diunduh! (mock)")),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,


      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detail Sesi'),
        centerTitle: true,
      ),


      body: Stack(
        children: [
          // BACKGROUND ATAS
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220,
            child: Image.asset("assets/bgsesi.png", fit: BoxFit.cover),
          ),


          // PUTIH BESAR DI BAWAH
          Positioned.fill(
            top: 85,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================== PROFIL TUTOR ===================
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/bgpink.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),


                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // FOTO PROFIL
                        const CircleAvatar(
                          radius: 36,
                          backgroundImage: AssetImage("assets/tutorsesi.png"),
                          backgroundColor: Colors.white, // <-- latar putih
                        ),
                        const SizedBox(width: 14),


                        // NAMA + JABATAN + RATING
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Khalila',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),


                              const Text(
                                'Dosen Pemrograman',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),


                              const SizedBox(height: 8),


                              // =================== RATING DALAM PROFIL ===================
                              Row(
                                children: List.generate(5, (i) {
                                  bool filled = i < rating;


                                  return Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Icon(
                                      filled ? Icons.star : Icons.star_border,
                                      color:
                                          filled ? const Color.fromARGB(255, 255, 247, 7) : Colors.white,
                                      size: 22,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),


                        // HARGA + STATUS
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
                  ),


                  const SizedBox(height: 20),


                  // =================== INFO SESI ===================
                  const Text(
                    "Sesi Telah Selesai",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),


                  const SizedBox(height: 10),


                  const Text(
                    "Pertemuan 1 Object Oriented Programming",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  const Text("4 Agustus 2024"),
                  const SizedBox(height: 4),
                  const Text("16.00 - 16.50 WIB"),


                  const SizedBox(height: 14),


                  Container(
                    width: double.infinity,
                    height: 3,
                    color: const Color.fromARGB(255, 183, 212, 235),
                  ),


                  const SizedBox(height: 14),


                  // =================== REKAMAN ===================
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/bgbiru.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.play_circle_fill,
                            color: Colors.green),
                        const SizedBox(width: 10),


                        const Expanded(
                          child: Text('Rekaman Sesi Tutor tersedia'),
                        ),


                        IconButton(
                          onPressed: downloadedRecording
                              ? null
                              : _downloadRecording,
                          icon: Icon(
                            downloadedRecording
                                ? Icons.check_circle
                                : Icons.download_outlined,
                            color: downloadedRecording
                                ? Colors.green
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),


                  const Spacer(),


                  // =================== BUTTON REVIEW ===================
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/reviewPage'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2340),
                      ),
                      child: const Text("REVIEW"),
                    ),
                  ),


                  const SizedBox(height: 10),


                  // =================== BUTTON HOME ===================
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/homepage',
                        (route) => false,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text("KEMBALI KE HOME"),
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
