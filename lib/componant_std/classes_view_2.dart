import 'package:flutter/material.dart';

class CardData {
  late final String? lecName;
  late final String? lecId;
  late final String? userName;
  late final String? lecStart;
  late final String? lecEnd;
  late final String? studentStatus;

  CardData(
      {required this.lecName,
      required this.lecId,
      required this.userName,
      required this.lecStart,
      required this.lecEnd,
      required this.studentStatus});
}

class ClassesViewSTD extends StatelessWidget {
  const ClassesViewSTD(
      {super.key,
      required this.lectureName,
      required this.userName,
      required this.startDate,
      required this.endDate,
      required this.status});

  final String? lectureName;
  final String? userName;
  final String? startDate;
  final String? endDate;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                    lectureName!,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userName!,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Status: $status',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.0,
                        height: 33.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xaae0e0e0),
                            width: 1.5,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
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
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        width: 120.0,
                        height: 33.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xaae0e0e0),
                            width: 1.5,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
