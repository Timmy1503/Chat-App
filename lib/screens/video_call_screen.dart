import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget{
  final AgoraClient _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: "80801dd08f944927ad29a517cdd48eee",
          tempToken: "00680801dd08f944927ad29a517cdd48eeeIACHQgDrXoPjxztCm8QYs+bs51GSa+WNTvKvGQ6JlRsdassaqekAAAAAEACu7KwLtnnMYQEAAQC1ecxh",
          channelName: "Chat-App"
      ),
      enabledPermission: [
        Permission.microphone,
        Permission.camera
      ]);

  VideoCallScreen({Key? key}) : super(key: key);
  void initAgora() async {
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                AgoraVideoViewer(
                  client: _client,
                ),
                AgoraVideoButtons(client: _client)
              ],
            )
        )
    );
  }
}