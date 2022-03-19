import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_meeting_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/meeting_options.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetingMethods _jitsiMeetingMethods = JitsiMeetingMethods();

  late TextEditingController _meetingIdController;
  late TextEditingController _nameController;

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    _meetingIdController = TextEditingController();
    _nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    _meetingIdController.dispose();
    _nameController.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  void _joinMeeting() {
    _jitsiMeetingMethods.createMeeting(
      roomName: _meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: _nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _meetingIdController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  fillColor: kSecondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Enter Meeting ID",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _nameController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  fillColor: kSecondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Enter Name",
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _joinMeeting,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Join",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            MeetingOption(
              text: "Mute Audio",
              isMute: isAudioMuted,
              onChanged: onAudioChanged,
            ),
            MeetingOption(
              text: "Mute Video",
              isMute: isVideoMuted,
              onChanged: onVideoChanged,
            ),
          ],
        ),
      ),
    );
  }

  onAudioChanged(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoChanged(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
