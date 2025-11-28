import 'package:flutter/material.dart'; 

class DetailSesiPage extends StatefulWidget {
  const DetailSesiPage({super.key});

  @override
  State<DetailSesiPage> createState() => _DetailSesiPageState();
}

class _DetailSesiPageState extends State<DetailSesiPage> {
  bool downloaded = false;
  int rating = 0;
  bool hasRecording = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // check if navigator passed argument that recording available
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      if (args['hasRecording'] == true) {
        setState(() {
          hasRecording = true;
        });
      }
    }
  }

  void _doDownload() async {
    // Simulate download
    setState(() => downloaded = true);
    // Show success modal (push named to existing page)
    await Navigator.pushNamed(context, '/downloadSuccess');
    // You can also save a file here; currently simulated
  }

  Widget _buildStar(int index) {
    return IconButton(
      onPressed: () => setState(() => rating = index),
      icon: Icon(
        index <= rating ? Icons.star : Icons.star_border,
        color: index <= rating ? Colors.amber : Colors.grey,
      ),
      iconSize: 28,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // soft bg color on top similar to figma
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Detail Sesi', style: TextStyle(color: Colors.black87)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // main card container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0,6))],
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // rounded tutor photo
                        CircleAvatar(
                          radius: 36,
                          backgroundImage: AssetImage("assets/tutor.png"),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Khalila', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 4),
                              Text('Dosen Pemrograman', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                        // price and online badge
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Rp50.000', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.greenAccent.shade100, borderRadius: BorderRadius.circular(8)),
                              child: const Text('ONLINE', style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // rating row
                    Row(
                      children: [
                        const Text('Rating:', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(width: 8),
                        Row(children: List.generate(5, (i) => _buildStar(i + 1))),
                        const SizedBox(width: 8),
                        Text('($rating)', style: const TextStyle(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // description
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Materi Java Object Oriented Programming\nWaktu: 10.00 - 11.00\nDeskripsi: Belajar OOP dasar sampai lanjutan.',
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // material card + download icon
                    Container(
                      decoration: BoxDecoration(color: Color(0xFFFDE0E6), borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.menu_book_outlined),
                          const SizedBox(width: 8),
                          const Expanded(child: Text('Materi Java Object Oriented Programming')),
                          IconButton(
                            onPressed: downloaded ? null : _doDownload,
                            icon: Icon(downloaded ? Icons.check_circle : Icons.download_outlined, color: downloaded ? Colors.green : Colors.black87),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // recording indicator (shows when available)
                    if (hasRecording)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(color: Color(0xFFDFF6EE), borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.play_circle_fill, color: Colors.green),
                            const SizedBox(width: 10),
                            const Expanded(child: Text('Rekaman Sesi Tutor tersedia')),
                            TextButton(
                              onPressed: () {
                                // open a mock player or show snackbar
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Memutar rekaman (mock)')));
                              },
                              child: const Text('Putar'),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // join button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // here we simulate not started, show popup; popup has "Coba Gabung" to go to calling
                    Navigator.pushNamed(context, '/popupBelumDimulai');
                  },
                  child: const Text('GABUNG SESI'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
