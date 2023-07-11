import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import '../models/attend_list_element_model.dart' as std;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../componant/appbar_custom.dart';
import '../constants.dart';
import '../models/attend_lec_model.dart';
import '../models/attend_sec_model.dart';
import '../models/auth_state.dart';
import '../services/base_client.dart';
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
  late String lectureId;
  late String lectureName;
  String? total;
  String? here;
  String? absent;

  String? _authToken;
  String? _authType;
  String? _authId;
  String? _regToken;
  late bool _isLoaded;

  bool _notSaved = true;
  List<std.StudentListElement>? serverList;

  void updateServerList(List<std.StudentListElement>? newList) {
    setState(() {
      serverList = newList;
    });
    print(
        'yes yes yes yes yes yes yes   second is serverList = newList yyyyyara ');
  }

  // void userChange(String targetId) {
  //   for (int i = 0; i < serverList!.length; i++) {
  //     if (serverList![i].studentId.id == targetId) {
  //       setState(() {
  //         serverList![i].status = !serverList![i].status;
  //       });
  //       print('yara      .....................        done:)');
  //       break; // Exit the loop after updating the student's status
  //     }
  //   }
  // }

  List<StudentItem> tasks = [];

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  List<StudentItem> _filteredData = [];

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

  // void _updateFilteredData(String searchTerm) {
  //   setState(() {
  //     _filteredData = _data
  //         .where(
  //             (item) => item.toLowerCase().contains(searchTerm.toLowerCase()))
  //         .toList();
  //   });
  // }

  showError(String data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error...'),
        content: Text(data),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

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
    loadToken();
  }

  Future<void> loadToken() async {
    // load the authToken from shared preferences
    // final tokenState = TokenSaved();
    setState(() {
      _isLoaded = false;
    });
    //////////////////////////////////////////////////get token first.
    await tokenState.getAuthToken().then((value) {
      setState(() {
        _authToken = value;
      });
    });
    print('my token $_authToken');
    //////////////////////////////////////////////////then get type.
    await tokenState.getAuthType().then((value) {
      setState(() {
        _authType = value;
      });
    });
    print('my type $_authType');
    //////////////////////////////////////////////////then get id.
    await tokenState.getAuthId().then((value) {
      setState(() {
        _authId = value;
      });
    });
    print('my id $_authId');
    //////////////////////////////////////////////////then get registeration token.
    await tokenState.getRegisterationToken().then((value) {
      setState(() {
        _regToken = value;
      });
    });
    print('my registeration token $_regToken');
    await passedData();
    checkLoadedData();
  }

  void checkLoadedData() async {
    await fetchStudentData('');
    setState(() {
      _isLoaded = true;
    });
  }

  Future<void> fetchStudentData(String filter) async {
    setState(() {
      tasks.clear();
    });

    final List<String> words = lectureName.split(' ');
    String firstWord = words[0].toLowerCase();

    if (firstWord == 'section') {
      const endpoint = 'section-list';
      print('yara ......................:  $lectureId');
      var response = await BaseClient()
          .get(
              '/$endpoint/$lectureId$filter',
              _authToken!,
              errTxt: 'can\'t load Student list ...',
              showError)
          .catchError((err) {
        print('yaraaaaaaaaaa error $err');
      });
      if (response == null) return;

      final data = attendanceSectionModelFromJson(response);
      if (filter == '') {
        setState(() {
          serverList = data.studentList?.cast<std.StudentListElement>();
        });
        //print(serverList);
        // print('...........................................');
        // print(json.encode(serverList));
      }
      setState(() {
        total = data.total.toString();
        here = data.here.toString();
        absent = data.absent.toString();
      });
      if (data.studentList != null) {
        for (int i = 0; i < data.studentList!.length; i++) {
          final stdId = data.studentList?[i].studentId.id;
          final stdName = data.studentList?[i].studentId.name;
          final stdImg = data.studentList?[i].snapshot;
          final stdStatus = data.studentList?[i].status;
          setState(() {
            tasks.add(StudentItem(
              name: stdName.toString(),
              status: stdStatus,
              id: stdId,
              img: stdImg,
            ));
          });
        }
      }
    } else {
      const endpoint = 'lecture';
      print('yara ......................:  $lectureId');
      var response = await BaseClient()
          .get(
              '/$endpoint/$lectureId$filter',
              _authToken!,
              errTxt: 'can\'t load Student list ...',
              showError)
          .catchError((err) {
        print('yaraaaaaaaaaa error $err');
      });
      if (response == null) return;

      final data = attendanceLectureModelFromJson(response);
      if (filter == '') {
        setState(() {
          serverList = data.studentList?.cast<std.StudentListElement>();
        });
        //print(serverList);
        // print('...........................................');
        // print(json.encode(serverList));
      }
      setState(() {
        total = data.total.toString();
        here = data.here.toString();
        absent = data.absent.toString();
      });
      if (data.studentList != null) {
        for (int i = 0; i < data.studentList!.length; i++) {
          final stdId = data.studentList?[i].studentId.id;
          final stdName = data.studentList?[i].studentId.name;
          final stdImg = data.studentList?[i].snapshot;
          final stdStatus = data.studentList?[i].status;
          setState(() {
            tasks.add(StudentItem(
              name: stdName.toString(),
              status: stdStatus,
              id: stdId,
              img: stdImg,
            ));
          });
        }
      }
    }
  }

  Future<void> patchAttendance() async {
    if (_authType == 'professor') {
      print('yara ......................:  $lectureId');
      // final str = List<dynamic>.from(serverList!.map((x) => x.toJson()));
      // print(str);
      // final str2 = json.encode(serverList);
      // print('...........................................');
      // print(str2);
      // print('...........................................');
      final myObject = {"attendanceList": serverList};
      // print(myObject);
      // print('...........................................');
      // print(json.encode(myObject));
      // print('...........................................');
      final List<String> words = lectureName.split(' ');
      String firstWord = words[0].toLowerCase();
      if (firstWord == 'lecture' || firstWord == 'lecture:') {
        var response = await BaseClient()
            .patch(
                '/attendance/$lectureId?deviceToken=${_regToken!}',
                _authToken!,
                myObject,
                errTxt: 'can\'t send attendance list to the server ...',
                showError)
            .catchError((err) {
          print('yaraaaaaaaaaa error $err');
        });
        if (response == null) return;
        final data = json.decode(response);
        print('yaaaaaaaaaaaaaaaaaaaaaaaaaaaaa patch response is : $data');
      } else {
        // Show toast message
        Fluttertoast.showToast(
          msg: 'You can only see this Attendance list.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        setState(() {
          _notSaved = !_notSaved;
        });
      }
    } else if (_authType == 'assistant') {
      print('yara ......................:  $lectureId');
      final myObject = {"attendanceList": serverList};
      final List<String> words = lectureName.split(' ');
      String firstWord = words[0].toLowerCase();
      if (firstWord == 'lecture' || firstWord == 'lecture:') {
        // Show toast message
        Fluttertoast.showToast(
          msg: 'You can only see this Attendance list.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        setState(() {
          _notSaved = !_notSaved;
        });
      } else {
        var response = await BaseClient()
            .patch(
                '/section-attendance/$lectureId?deviceToken=${_regToken!}',
                _authToken!,
                myObject,
                errTxt: 'can\'t send attendance list to the server ...',
                showError)
            .catchError((err) {
          print('yaraaaaaaaaaa error $err');
        });
        if (response == null) return;
        final data = json.decode(response);
        print('yaaaaaaaaaaaaaaaaaaaaaaaaaaaaa patch response is : $data');
      }
    }
  }

  Future<void> saveAsPDF(List<std.StudentListElement>? students) async {
    // // Get the temporary directory for storing the PDF file
    // Directory tempDir = await getTemporaryDirectory();
    // String tempPath = tempDir.path;
    // // Generate a unique filename for the PDF
    // String pdfFileName =
    //     'saved_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
    // String pdfFilePath = '$tempPath/$pdfFileName';
    /////////////////////////////////////////////////////////////////////////
    // Get the downloads directory
    // Directory downloadsDir;
    // if (!kIsWeb) {
    //   // Running on a physical device or emulator
    //   downloadsDir = (await getDownloadsDirectory())!;
    // } else {
    //   // Running in a web browser
    //   print('Saving PDF not supported on web platform.');
    //   return;
    // }
    // if (downloadsDir == null) {
    //   print('Unable to access the Downloads directory.');
    //   return;
    // }
    // // Generate a unique filename for the PDF
    // String pdfFileName =
    //     'saved_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
    // String pdfFilePath = '${downloadsDir.path}/$pdfFileName';
    /////////////////////////////////////////////////////////////////////////
    // Get the documents directory
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;

    // Generate a unique filename for the PDF
    String pdfFileName =
        'saved_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
    String pdfFilePath = '$documentsPath/$pdfFileName';
    //////////////////////////////////////////////////////////
    // Create a PDF document
    final pdf = pw.Document();

    // Create a table header row
    final tableHeaders = ['ID', 'Name', 'Status'];
    final tableHeaderRow =
        tableHeaders.map((header) => pw.Text(header)).toList();
    final headerRow = pw.TableRow(children: tableHeaderRow);

    // Create table data rows for each student
    final tableRows = students!.map(
      (student) => pw.TableRow(
        children: [
          pw.Text(student.studentId.id),
          pw.Text(student.studentId.name),
          pw.Text(student.status.toString()),
        ],
      ),
    );

    // Add the table to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table(
            children: [
              headerRow, // Add the header row
              ...tableRows, // Add the data rows
            ],
          );
        },
      ),
    );

    // Save the PDF to a file
    final File file = File(pdfFilePath);
    await file.writeAsBytes(await pdf.save());

    print('yyyyyyyyyyyyyyyyyy PDF saved at: $pdfFilePath');

    // Show toast message
    Fluttertoast.showToast(
      msg: 'Attendance list has been saved as PDF in your internal storage.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );

    // Open the saved PDF file
    OpenFile.open(pdfFilePath);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    passedData();
  }

  Future<void> passedData() async {
    // Access the passed data using ModalRoute
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    lectureId = args['lectureId'];
    lectureName = args['lectureName'];
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
                            data: _isLoaded ? total.toString() : '/',
                            colour: const Color(0xff0D8AD5),
                            func: () async {
                              await fetchStudentData('');
                            },
                          ),
                          WhiteBox(
                            label: 'Here',
                            data: _isLoaded ? here.toString() : '/',
                            colour: const Color(0xff9DEAC0),
                            func: () async {
                              await fetchStudentData('?filter=here');
                            },
                          ),
                          WhiteBox(
                            label: 'Absent',
                            data: _isLoaded ? absent.toString() : '/',
                            colour: const Color(0xffFF9A9A),
                            func: () async {
                              await fetchStudentData('?filter=absent');
                            },
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
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
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
                            myList: serverList,
                            onUpdateMyList: updateServerList,
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
                                onPress: () async {
                                  setState(() {
                                    _notSaved = false;
                                  });
                                  //save all the changes to the database
                                  await patchAttendance();
                                  //and fetch the updated data from the database like (total,absent,here,student list)
                                  await fetchStudentData('');
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
                                onPress: () async {
                                  setState(() {
                                    _notSaved = true;
                                  });
                                  //do the downloading process
                                  await saveAsPDF(serverList);

                                  // print('Student list: ...');
                                  // for (var element in _filteredData) {
                                  // print(element.name);
                                  // print(element.status);
                                  // }
                                  // for (var i = 0; i < serverList!.length; i++) {
                                  //   print(serverList![i].studentId.name);
                                  //   print(serverList![i].status);
                                  // }
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
  bool? status;
  String? id;
  String? img;

  StudentItem({required this.name, this.status, this.id, this.img});

  void toggleDone(List<std.StudentListElement>? serverList) {
    status = !status!;
    for (int i = 0; i < serverList!.length; i++) {
      if (serverList[i].studentId.id == id) {
        // Set the new status for the student
        serverList[i].status = !serverList[i].status;
        print('yyyyyyyyyyyyyyyyyyyyyyyyyy  first toggle is done ');
        break; // Exit the loop after updating the student's status
      }
    }
  }

  // Future<void> userChange(List<StudentListElement>? serverList) async {
  //   for (int i = 0; i < serverList!.length; i++) {
  //     if (serverList[i].studentId.id == id) {
  //       serverList[i].status =
  //           !serverList[i].status; // Set the new status for the student
  //       print('yyyyyyyyyyyyyyyyyyyyyyyyyy  99999999');
  //       break; // Exit the loop after updating the student's status
  //     }
  //   }
  // }
}

class StudentTile extends StatelessWidget {
  const StudentTile(
      {super.key,
      this.isChecked,
      this.imgurl =
          'https://icon-library.com/images/username-icon/username-icon-28.jpg',
      required this.studentTitle,
      this.switchCallback});

  final bool? isChecked;
  final String? imgurl;
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
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            child: Image(
              image: NetworkImage(imgurl.toString()),
              fit: BoxFit.cover,
              height: 25.0,
              width: 25.0,
            ),
          ),
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
            // thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
            //   (Set<MaterialState> states) {
            //     // Thumb icon when the switch is selected.
            //     if (states.contains(MaterialState.selected)) {
            //       return const Icon(Icons.check, color: Color(0xff21005D));
            //     } // Thumb icon when the switch is disabled.
            //     return const Icon(Icons.close, color: Color(0xff21005D));
            //   },
            // ),
            onChanged: switchCallback,
          )
        ],
      ),
    );
  }
}

class StudentList extends StatefulWidget {
  const StudentList({
    super.key,
    this.students,
    required this.myList,
    required this.onUpdateMyList,
  });
  final List<StudentItem>? students;
  final List<std.StudentListElement>? myList;
  final Function(List<std.StudentListElement>) onUpdateMyList;
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  // List<StudentListElement>? serverList;

  // @override
  // void initState() {
  //   super.initState();
  //   // Assign the value of myList to serverList in the initState method
  //   serverList = widget.myList;
  // }

  void updateMyList(List<std.StudentListElement> newList) {
    // Invoke the callback function to update serverList
    widget.onUpdateMyList(newList);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.students!.length,
      itemBuilder: (BuildContext context, int index) {
        return StudentTile(
            //imgurl: widget.students![index].img.toString(),
            studentTitle: widget.students![index].name,
            isChecked: widget.students![index].status,
            switchCallback: (bool? value) {
              setState(() {
                widget.students![index].toggleDone(widget.myList!);
                // widget.students![index].userChange(widget.myList);
                updateMyList(widget.myList!);
              });
              // Update myList and invoke the callback
              // updateMyList(widget.myList!);
              print(widget.students![index].name);
              print(widget.students![index].status);
              print(widget.students![index].id);
            });
      },
    );
  }
}

class WhiteBox extends StatelessWidget {
  const WhiteBox(
      {super.key,
      required this.label,
      required this.data,
      required this.colour,
      required this.func});

  final String label;
  final String data;
  final Color? colour;
  final Function()? func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: 95.0,
        margin: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
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
      ),
    );
  }
}
