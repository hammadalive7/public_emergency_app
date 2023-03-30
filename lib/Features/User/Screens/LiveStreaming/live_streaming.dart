import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'live_stream.dart';

class LiveStreamUser extends StatefulWidget {
  const LiveStreamUser({Key? key}) : super(key: key);

  @override
  State<LiveStreamUser> createState() => _LiveStreamUserState();
}

final idController = TextEditingController();

class _LiveStreamUserState extends State<LiveStreamUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: idController,
            decoration: const InputDecoration(
              hintText: 'Enter ID',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              jumpToLiveStream(context, idController.text, true);
            },
            child: const Text('Start Live Stream'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              jumpToLiveStream(context, idController.text, false);
            },
            child: const Text('Watch Live Stream'),
          ),
        ],
      ),
    );
  }

  jumpToLiveStream(BuildContext context, String liveId, bool isHost) {
    if (idController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiveStreamingPage(
            liveId: liveId,
            isHost: isHost,
          ),
        ),
      );
    } else {
      Get.snackbar("Error", "Please enter a valid ID");
    }
  }
}
