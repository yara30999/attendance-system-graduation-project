import 'package:flutter/material.dart';
import '../screens/camera_screen.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard(
      {super.key,
      required this.lectureName,
      required this.lectureTime,
      required this.lectureId,
      required this.userName,
      required this.visible});

  final String? lectureName;
  final dynamic lectureTime;
  final String? lectureId;
  final String? userName;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      height: 130.0,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 210, 211, 211)),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lectureName!,
                style: const TextStyle(
                    color: Color(0xff074E79),
                    fontSize: 18.0,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500),
              ),
              Text(
                userName!,
                style: const TextStyle(
                    color: Color.fromARGB(255, 100, 100, 101),
                    fontSize: 13.0,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500),
              ),
              Text(
                lectureTime,
                style: const TextStyle(
                    color: Color.fromARGB(255, 100, 100, 101),
                    fontSize: 13.0,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: visible,
                child: GestureDetector(
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 30.0,
                    color: Color(0xff074E79),
                  ),
                  onTap: () {
                    print('camera (1) clicked');
                    // use the lec id here ya yaaaaaaaaaara
                    Navigator.pushNamed(
                      context,
                      CameraScreen.id,
                      arguments: {
                        'lectureId': lectureId,
                        'lectureName': lectureName,
                      },
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
