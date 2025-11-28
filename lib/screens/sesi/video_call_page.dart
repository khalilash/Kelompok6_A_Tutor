import 'package:flutter/material.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool muted = false;
  bool videoOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // full screen video
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/vc.png", fit: BoxFit.cover)),
          Positioned(
            top: 36,
            right: 16,
            child: Container(
              width: 110,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white70),
                image: const DecorationImage(image: AssetImage("assets/murid.png"), fit: BoxFit.cover),
              ),
            ),
          ),
          // top back icon
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          // controls bottom
          Positioned(
            bottom: 36,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'mute_call',
                  backgroundColor: Colors.white24,
                  onPressed: () => setState(() => muted = !muted),
                  child: Icon(muted ? Icons.mic_off : Icons.mic),
                ),
                const SizedBox(width: 28),
                FloatingActionButton(
                  heroTag: 'cam_switch',
                  backgroundColor: Colors.white24,
                  onPressed: () => setState(() => videoOn = !videoOn),
                  child: Icon(videoOn ? Icons.videocam : Icons.videocam_off),
                ),
                const SizedBox(width: 28),
                FloatingActionButton(
                  heroTag: 'end_call',
                  backgroundColor: Colors.red,
                  onPressed: () {
                    // navigate to finish screen
                    Navigator.pushReplacementNamed(context, '/tutorSelesai');
                  },
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
