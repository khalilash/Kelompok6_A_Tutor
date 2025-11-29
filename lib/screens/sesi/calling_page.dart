import 'package:flutter/material.dart';




class CallingPage extends StatelessWidget {
  const CallingPage({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // dark background for calling
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(opacity: 0.65, child: Image.asset("assets/vcmurid.png", fit: BoxFit.cover)),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(radius: 70, backgroundImage: AssetImage("assets/tutorsesi.png", ), backgroundColor: Colors.white),
                  const SizedBox(height: 16),
                  const Text('Khalila', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Berdering...', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton(
                        heroTag: 'mute',
                        onPressed: () {},
                        backgroundColor: Colors.white24,
                        mini: true,
                        child: const Icon(Icons.mic_off, color: Colors.white),
                      ),
                      const SizedBox(width: 18),
                      FloatingActionButton(
                        heroTag: 'accept',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/videoCallPage');
                        },
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.call, color: Colors.white),
                      ),
                      const SizedBox(width: 18),
                      FloatingActionButton(
                        heroTag: 'decline',
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.call_end, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
