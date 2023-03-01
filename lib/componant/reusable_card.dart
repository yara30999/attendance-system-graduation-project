import 'package:fast_tende_doctor_app/componant/user_photo.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.all(10.0),
      height: 130.0,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 210, 211, 211)),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              UserPhoto(img: 'images/user1.png', rounded: false),
              SizedBox(height: 18.0),
              Text(
                '10:15 AM',
                style: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 101),
                    fontSize: 13.0,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(width: 30.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'math lecture',
                style: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 101),
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
              GestureDetector(
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 30.0,
                  color: Color(0xff074E79),
                ),
                onTap: () {
                  print('camera (1) clicked');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
