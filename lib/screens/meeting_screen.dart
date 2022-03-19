import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/jitsi_meeting_methods.dart';
import 'package:zoom_clone/utils/custom_uuid.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);

  final JitsiMeetingMethods _jitsiMeetingMethods = JitsiMeetingMethods();

  createNewMeeting() async {
    var uid = CustomUUID.generateUUID();
    _jitsiMeetingMethods.createMeeting(
      roomName: uid,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, "/video_call");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              text: "New Meeting",
              icon: Icons.videocam_rounded,
              onPressed: createNewMeeting,
            ),
            HomeMeetingButton(
              text: "Join",
              icon: Icons.add_box_rounded,
              onPressed: () => joinMeeting(context),
            ),
            HomeMeetingButton(
              text: "Schedule",
              icon: Icons.calendar_today_rounded,
              onPressed: () {},
            ),
            HomeMeetingButton(
              text: "Share Screen",
              icon: Icons.arrow_upward_rounded,
              onPressed: () {},
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              "Create/Join meetings with just a click!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
