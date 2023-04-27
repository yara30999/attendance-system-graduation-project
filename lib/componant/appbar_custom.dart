import 'package:flutter/material.dart';

class AppbarCustom extends StatelessWidget {
  const AppbarCustom({
    super.key,
    required this.label,
    this.onpress,
  });

  final String label;
  final Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onpress,
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff074E79),
            ),
          ),
          const SizedBox(width: 80.0),
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(label,
                style: const TextStyle(
                    letterSpacing: 0.6,
                    fontSize: 20.0,
                    color: Color(0xff074E79),
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
