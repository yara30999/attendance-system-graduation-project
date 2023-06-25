import 'package:fast_tende_doctor_app/componant/user_photo.dart';
import 'package:flutter/material.dart';


class ReusableCardSTD extends StatelessWidget {
  const ReusableCardSTD(
      {super.key, required this.lectureName, required this.lectureTime});

  final String lectureName;
  final dynamic lectureTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.all(10.0),
      height: 120.0,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 210, 211, 211)),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const UserPhoto(img: 'images/user1.png', rounded: false),
              const SizedBox(height: 18.0),
              Text(
                '$lectureTime AM',
                style: const TextStyle(
                    color: Color.fromARGB(255, 100, 100, 101),
                    fontSize: 13.0,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(width: 30.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lectureName.toLowerCase(),
                style: const TextStyle(
                    color: Color(0xff074E79),
                    fontSize: 18.0,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                'Dr. mohammed ahmed',
                style: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 101),
                    fontSize: 13.0,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
