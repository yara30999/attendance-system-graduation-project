import 'package:flutter/material.dart';
import '../screens/attendance_list.dart';

class ClassesView extends StatelessWidget {
  const ClassesView({
    super.key,
    required this.lectureName,
    required this.doctorName,
    required this.startDate,
    required this.endDate,
    required this.total,
    required this.here,
    required this.absent,
  });

  final String lectureName;
  final String doctorName;
  final String startDate;
  final String endDate;
  final String total;
  final String here;
  final String absent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AttendanceListScreen.id,
          arguments: {
            'lectureName': lectureName,
            'total': total,
            'here': here,
            'absent': absent,
          },
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            //because A borderRadius can only be given for a uniform Border.
            //so we comment the next line...& using (ClipRRect)
            //borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: const Border(
                left: BorderSide(width: 2.0, color: Color(0xff0D8AD5))),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lectureName,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                child: Container(
                  width: 160.0,
                  height: 33.0,
                  color: const Color(0xffF3F3F3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start $startDate',
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        'End $endDate',
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              // Text(
              //   '$here Out of $total are here \n$absent Out of $total are Absent',
              //   style: const TextStyle(
              //       fontSize: 16.0,
              //       fontWeight: FontWeight.w400,
              //       color: Colors.black),
              // ),
              Row(
                children: [
                  Text(
                    here,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const Text(
                    ' Out of ',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    total,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const Text(
                    ' are here ',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    absent,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const Text(
                    ' Out of ',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    total,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const Text(
                    ' are Absent ',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
