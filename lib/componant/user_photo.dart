import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({super.key, required this.img, required this.rounded});
  final String img;
  final bool rounded;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: rounded
          ? const BorderRadius.all(Radius.circular(50.0))
          : const BorderRadius.all(Radius.circular(20.0)),
      child: Image(
        image: AssetImage(img),
        fit: BoxFit.cover,
        height: 56.3,
        width: 57.6,
      ),
    );
  }
}
