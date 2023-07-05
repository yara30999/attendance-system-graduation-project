import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../componant/search_field.dart';
import '../componant/user_photo.dart';
import '../constants.dart';
import '../componant_std/classes_tab_2.dart';
import '../componant_std/sections_tap_2.dart';
import '../models/auth_state.dart';
import '../models/std_lec_model.dart';
import '../models/std_sec_model.dart';
import '../services/base_client.dart';

class STDHomeScreen extends StatefulWidget {
  const STDHomeScreen({super.key});
  static String id = 'std_home_screen';

  @override
  State<STDHomeScreen> createState() => _STDHomeScreenState();
}

class _STDHomeScreenState extends State<STDHomeScreen> {
  late String _selectedDate; // for the calendar
  String? _authToken;
  String? _authType;
  String? _authName;
  late bool _isLoaded;
  bool _lecIsLoaded = false;
  bool _secIsLoaded = false;

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

// <<<1>>>>  from here ......................................
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<LectureDataSTD> lectureList = [
    // LectureDataSTD(name: 'info lecture', time: '12:30'),
    // LectureDataSTD(name: 'ecommerce1 section', time: '12:30'),
    // LectureDataSTD(name: 'math lecture', time: '12:30'),
    // LectureDataSTD(name: 'ecommerce2 lecture', time: '12:30'),
    // LectureDataSTD(name: 'ecommerce3 lecture', time: '12:30'),
    // LectureDataSTD(name: 'mobile lecture', time: '12:30'),
    // LectureDataSTD(name: 'security lecture', time: '12:30'),
  ];
  List<SectionDataSTD> sectionlist = [
    // SectionDataSTD(name: 'security section', time: '12:30'),
    // SectionDataSTD(name: 'ecommerce section', time: '12:30'),
    // SectionDataSTD(name: 'ecommerce section', time: '12:30'),
    // SectionDataSTD(name: 'ecommerce section', time: '12:30'),
  ];

  List<LectureDataSTD> _filteredData = [];

  void _updateFilteredData(String searchTerm) {
    setState(() {
      _filteredData = lectureList
          .where((item) =>
              item.lecName!.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = '2023-6-20';
    _filteredData = lectureList;
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
    //////////////////////////////////////////////////then get name.
    await tokenState.getAuthName().then((value) {
      setState(() {
        _authName = value;
      });
    });
    print('my name $_authName');
    checkLoadedData();
  }

  void checkLoadedData() async {
    await fetchLectureData();
    await fetchSectionsData();
    if (_lecIsLoaded && _secIsLoaded) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  Future<void> fetchLectureData() async {
    setState(() {
      lectureList.clear();
    });
    var response = await BaseClient()
        .get(
            '/student-lectures/$_selectedDate',
            _authToken!,
            errTxt: 'can\'t load lecture data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });
    if (response == null) return;

    final data = studentLectureModelFromJson(response);
    if (data.lectures != null) {
      for (int i = 0; i < data.lectures!.length; i++) {
        final lectureId = data.lectures?[i].id;
        final lectureName = data.lectures?[i].subjectId?.name;
        final lectureOwner = 'Dr. ${data.lectures?[i].profId?.name}';
        final lectureTime = data.lectures == null
            ? null
            : DateFormat('H:mm').format(data.lectures![i].date);

        setState(() {
          // lectureList.clear();

          lectureList.add(LectureDataSTD(
            lecId: lectureId,
            lecName: lectureName,
            lecTime: lectureTime,
            userName: lectureOwner,
          ));

          // _lecIsLoaded = true;
        });
      }
    }
    setState(() {
      _lecIsLoaded = true;
    });
  }

  Future<void> fetchSectionsData() async {
    setState(() {
      sectionlist.clear();
    });
    var response = await BaseClient()
        .get(
            '/student-sections/$_selectedDate',
            _authToken!,
            errTxt: 'can\'t load sections data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });

    if (response == null) return;

    final data = studentSectionModelFromJson(response);
    if (data.section != null) {
      for (int i = 0; i < data.section!.length; i++) {
        final sectionId = data.section?[i].id;
        final sectionName = data.section?[i].subjectId?.name;
        final sectionOwner = 'Eng. ${data.section?[i].assistId?.name}';
        final sectionTime = data.section == null
            ? null
            : DateFormat('H:mm').format(data.section![i].date);

        setState(() {
          //sectionlist.clear();

          sectionlist.add(SectionDataSTD(
            secId: sectionId,
            secName: sectionName,
            secTime: sectionTime,
            userName: sectionOwner,
          ));

          //_secIsLoaded = true;
        });
      }
    }
    setState(() {
      _secIsLoaded = true;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //<<<<<2>>>>>>  to here , just to use the serch field..................

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //blue container......
              Container(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 30.0, right: 30.0, bottom: 20.0),
                decoration: const BoxDecoration(
                  color: Color(0xff0d8ad5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(33.0),
                    bottomRight: Radius.circular(33.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        // 1) digital clock was here
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        ),
                        // 2) profile photo
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: UserPhoto(
                            img: 'images/user1.png',
                            rounded: false,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Let\'s find',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Your next class!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    // 3) search field
                    SearchField(
                      hintText: 'Search Class...',
                      height: 32.0,
                      side: BorderSide.none,
                      searchQuery: _searchQuery,
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
                          _searchQuery = '';
                          _filteredData = lectureList;
                          _searchController.clear();
                        });
                        // Perform clear search logic here
                        // e.g., reset search results, etc.
                      },
                      searchController: _searchController,
                    ),
                  ],
                ),
              ),
              // after the blue container/////////////////////////////////
              Container(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 30.0, right: 30.0, bottom: 20.0),
                child: Column(
                  children: [
                    DatePicker(
                      DateTime(2023, 6, 19),
                      initialSelectedDate: DateTime(2023, 6, 20),
                      selectionColor: const Color(0xff0d8ad5),
                      selectedTextColor: Colors.white,
                      monthTextStyle: const TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8A96BC),
                      ),
                      dateTextStyle: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff263257),
                      ),
                      dayTextStyle: const TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8A96BC),
                      ),
                      onDateChange: (selectedDate) {
                        setState(() {
                          _selectedDate =
                              DateFormat("yyyy-MM-dd").format(selectedDate);
                          print(_selectedDate);
                        });
                        checkLoadedData();
                      },
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                            child: TabBar(
                                labelColor: Colors.black,
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.w400),
                                indicatorColor: Color(0xff074E79),
                                //dividerColor: Color(0xff074E79),
                                tabs: [
                                  Tab(text: 'Classes'),
                                  Tab(text: 'Sections'),
                                ]),
                          ),
                          SizedBox(
                            height: 250.0,
                            child: Center(
                              child: TabBarView(children: [
                                ClassesTabSTD(lecture: _filteredData),
                                SectionsTabSTD(sections: sectionlist),
                              ]),
                            ),
                          )
                        ],
                      ),
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
