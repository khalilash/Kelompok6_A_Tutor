import 'package:flutter/material.dart';


class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});


  @override
  State<ReviewPage> createState() => _ReviewPageState();
}


class _ReviewPageState extends State<ReviewPage> {
  int rating = 4;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    final args = ModalRoute.of(context)?.settings.arguments;


    if (args is Map<String, dynamic>) {
      rating = args["ratingAwal"] ?? 4;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Sesi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),


      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/bgsesi.png",
              fit: BoxFit.cover,
            ),
          ),


          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.85),
            ),
          ),


          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),


              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("assets/tutorsesi.png"),
                      backgroundColor: Colors.white, // <-- latar putih
                    ),
                    title: const Text(
                      "Khalila",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Dosen Pemrograman"),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Selesai"),
                    ),
                  ),


                  const SizedBox(height: 12),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return IconButton(
                        icon: Icon(
                          i < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() {
                            rating = i + 1;
                          });
                        },
                      );
                    }),
                  ),


                  const SizedBox(height: 12),


                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Tulis ulasan kamu...",
                    ),
                  ),


                  const SizedBox(height: 20),


                  // =================== PERUBAHAN DI SINI ===================
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Terima kasih atas ulasannya!"),
                          ),
                        );


                        Navigator.pushReplacementNamed(
                          context,
                          '/sesiSelesai',
                          arguments: {
                            "rating": rating,
                          },
                        );
                      },
                      child: const Text("KIRIM ULASAN"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
