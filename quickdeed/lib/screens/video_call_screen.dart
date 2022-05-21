import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  final AgoraClient client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId:'acf2220752f449b8969294debe87dd3a',
          channelName: 'quickdeed',
          tempToken: '006acf2220752f449b8969294debe87dd3aIAA5K9ERQksnBuWT2blfE0o42zFPhzfwVqkgM6gshMBRvG49wDMAAAAAEABCwUE+IWyKYgEAAQAfbIpi'
      ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],);

  void initAgora() async {
    await client.initialize();
  }

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video call'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(client: client),
            AgoraVideoButtons(client: client),
          ],
        ),
      ),
    );
  }
}



















