import 'package:flutter/material.dart';
import '../componant/appbar_custom.dart';
import '../constants.dart';
import 'first_screen.dart';
import '../componant/class_view.dart';
import '../componant/search_field.dart';

class AttendanceListScreen extends StatefulWidget {
  const AttendanceListScreen({
    super.key,
  });

  static String id = 'attendance_list_screen';

  @override
  State<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  late String lectureName;
  late String total;
  late String here;
  late String absent;

  bool _notSaved = true;


  List<StudentItem> tasks = [
    StudentItem(name: 'yara nasser elden'),
    StudentItem(name: 'ahmed mohammed ali'),
    StudentItem(name: 'noor yasser ali'),
    StudentItem(name: 'noor yasser ali'),
    StudentItem(name: 'yara nasser elden'),
    StudentItem(name: 'ahmed mohammed ali'),
    StudentItem(name: 'yara nasser elden'),
  ];

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // final List<String> _data = [
  //   'Apple',
  //   'Banana',
  //   'Cherry',
  //   'Date',
  //   'Elderberry',
  //   'Fig',
  //   'Grapes',
  //   'Kiwi',
  //   'Lemon',
  //   'Mango',
  //   'Orange',
  //   'Peach',
  //   'Quince',
  //   'Raspberry',
  //   'Strawberry',
  //   'Tomato',
  //   'Ugli fruit',
  //   'Vineapple',
  //   'Watermelon',
  //   'Xigua',
  //   'Yellow passion fruit',
  //   'Zucchini',
  // ];
  // List<String> _filteredData = [];
  List<StudentItem> _filteredData = [];

  // void _updateFilteredData(String searchTerm) {
  //   setState(() {
  //     _filteredData = _data
  //         .where(
  //             (item) => item.toLowerCase().contains(searchTerm.toLowerCase()))
  //         .toList();
  //   });
  // }

  void _updateFilteredData(String searchTerm) {
    setState(() {
      _filteredData = tasks
          .where((item) =>
              item.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // _filteredData = _data;
    _filteredData = tasks;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the passed data using ModalRoute
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    lectureName = args['lectureName'];
    total = args['total'];
    here = args['here'];
    absent = args['absent'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarCustom(
                label: 'Attendance',
                onpress: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      lectureName,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 100.0,
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xff0D8AD5),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WhiteBox(
                            label: 'Total',
                            data: total,
                            colour: const Color(0xff0D8AD5),
                          ),
                          WhiteBox(
                            label: 'Here',
                            data: here,
                            colour: const Color(0xff9DEAC0),
                          ),
                          WhiteBox(
                            label: 'Absent',
                            data: absent,
                            colour: const Color(0xffFF9A9A),
                          ),
                        ],
                      ),
                    ),
                    SearchField(
                      hintText: 'Search...',
                      height: 40.0,
                      side: const BorderSide(
                        color: Color(0xff8C98BE),
                      ),
                      searchQuery: _searchQuery,
                      searchController: _searchController,
                      onSearchTextChanged: (String value) {
                        setState(() {
                          _searchQuery = value;
                        });
                        _updateFilteredData(value);
                        // Perform search logic here
                        // e.g., call a search function, update search results, etc.
                      },
                      onSearchClearPressed: () {
                        setState(() {
                          // _searchQuery = '';
                          // _filteredData = _data;
                          // _searchController.clear();
                          _searchQuery = '';
                          _filteredData = tasks;
                          _searchController.clear();
                        });
                        // Perform clear search logic here
                        // e.g., reset search results, etc.
                      },
                      //   box:
                      //       // SizedBox(
                      //       //   //to display the list of filterd data
                      //       //   height: 70,
                      //       //   child: ListView.builder(
                      //       //     itemCount: _filteredData.length,
                      //       //     itemBuilder: (context, index) => Container(
                      //       //       color: Colors.grey,
                      //       //       child:
                      //             // Text(
                      //             //   _filteredData[index],
                      //             // ),
                      //       //     ),
                      //       //   ),
                      //       // ),
                            // Container(
                            //   height: 200.0,
                            //   child: StudentList(
                            //                         students: _filteredData,
                            //                       ),
                            // ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0,),
                        const Text(
                          'Student List',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff232F55)),
                        ),
                        SizedBox(
                          height: 240.0,
                          //color: Colors.grey,
                          child: StudentList(
                            students: _filteredData,
                          ),
                        ),
                        Center(
                          child: Visibility(
                              visible: _notSaved,
                              child: CustomButton(
                                label: 'Save',
                                height: 35.0,
                                width: 100,
                                radius: 10.0,
                                onPress: () {
                                  setState(() {
                                    _notSaved = false;
                                  });
                                  //save all the changes to the database
                                  //and fetch the updated data from the database like (total,absent,here,student list)
                                },
                              )),
                        ),
                        Center(
                          child: Visibility(
                              visible: !_notSaved,
                              child: CustomButton(
                                label: 'Download as PDF',
                                icon: Icons.download,
                                height: 35.0,
                                width: 200.0,
                                radius: 20.0,
                                onPress: () {
                                  setState(() {
                                    _notSaved = true;
                                  });
                                  //do the downloading process
                                  print('Student list: ...');
                                  for (var element in _filteredData) {
                                    print(element.name);
                                    print(element.isHere);
                                  }
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPress,
    required this.label,
    required this.height,
    required this.width,
    required this.radius,
    this.icon,
  });
  final Function()? onPress;
  final String label;
  final double? height;
  final double? width;
  final double radius;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      constraints: BoxConstraints.tightFor(width: width, height: height),
      elevation: 5.0,
      disabledElevation: 5.0,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      fillColor: const Color(0xff0D8AD5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
              visible: icon != null,
              child: Icon(
                icon,
                color: Colors.white,
              )),
          Visibility(
              visible: icon != null,
              child: const SizedBox(
                width: 5.0,
              )),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class StudentItem {
  late final String name;
  bool? isHere;

  StudentItem({required this.name, this.isHere = false});

  void toggleDone() {
    isHere = !isHere!;
  }
}

class StudentTile extends StatelessWidget {
  const StudentTile(
      {super.key,
      this.isChecked,
      required this.studentTitle,
      this.switchCallback});

  final bool? isChecked;
  final String studentTitle;
  final Function(bool?)? switchCallback;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            studentTitle,
            style: const TextStyle(
                // decoration:
                //     isChecked == true ? TextDecoration.lineThrough : null
                    ),
          ),
          Switch(
            value: isChecked!,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xff9DEAC0),
            inactiveTrackColor: const Color(0xffFF9A9A),
            thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
              (Set<MaterialState> states) {
                // Thumb icon when the switch is selected.
                if (states.contains(MaterialState.selected)) {
                  return const Icon(Icons.check, color: Color(0xff21005D));
                } // Thumb icon when the switch is disabled.
                return const Icon(Icons.close, color: Color(0xff21005D));
              },
            ),
            onChanged: switchCallback,
          )
        ],
      ),
    );
  }
}

class StudentList extends StatefulWidget {
  const StudentList({super.key, this.students});
  final List<StudentItem>? students;

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.students!.length,
      itemBuilder: (BuildContext context, int index) {
        return StudentTile(
            studentTitle: widget.students![index].name,
            isChecked: widget.students![index].isHere,
            switchCallback: (bool? value) {
              setState(() {
                widget.students![index].toggleDone();
              });
              print(widget.students![index].name);
              print(widget.students![index].isHere);
            });
      },
    );
  }
}

class WhiteBox extends StatelessWidget {
  const WhiteBox({
    super.key,
    required this.label,
    required this.data,
    required this.colour,
  });

  final String label;
  final String data;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.0,
      margin:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data,
            style: TextStyle(
                fontSize: 30.0, fontWeight: FontWeight.w600, color: colour),
          ),
          Text(
            label,
            style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff8A96BC)),
          ),
        ],
      ),
    );
  }
}
