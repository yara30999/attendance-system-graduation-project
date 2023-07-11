import 'package:flutter/material.dart';
import '../componant/classes_tab.dart';
import '../componant/sections_tab.dart';
import '../componant/user_photo.dart';
import '../constants.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../componant/search_field.dart';
import '../componant/reusable_card.dart';
import '../models/auth_state.dart';
import '../services/base_client.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../models/filter_lec_model.dart';
import '../models/filter_pro_sec_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  List<LectureData> lectureList = [];
  List<SectionData> sectionlist = [];

  List<LectureData> _filteredData = [];

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
    if (_authType == 'assistant') {
      setState(() {
        lectureList.clear();
        _lecIsLoaded = true;
      });

      return;
    }
    setState(() {
      lectureList.clear();
    });
    var response = await BaseClient()
        .get(
            '/filterd-lectures/$_selectedDate',
            _authToken!,
            errTxt: 'can\'t load lecture data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });
    if (response == null) return;
    final data = filteredLectureModelFromJson(response);
    if (data.lectures != null) {
      for (int i = 0; i < data.lectures!.length; i++) {
        final lectureId = data.lectures?[i].id;
        final lectureName =
            'Lecture: \n\t\t\t\t${data.lectures?[i].subjectId?.name}';
        final lectureTime = data.lectures == null
            ? null
            : DateFormat('H:mm a').format(data.lectures![i].date);
        final personName = 'Dr. $_authName';
        const visible = true;
        setState(() {
          if (data.lectures != null) {
            lectureList.add(LectureData(
              lecId: lectureId,
              lecName: lectureName,
              lecTime: lectureTime,
              userName: personName,
              visible: visible,
            ));
          }
        });
      }
    }
    setState(() {
      _lecIsLoaded = true;
    });
  }

  Future<void> fetchSectionsData() async {
    final String endpoint;
    final bool visible;
    if (_authType == 'assistant') {
      endpoint = 'filtered-sections';
      visible = true;
    } else {
      endpoint = 'professor-sections';
      visible = false;
    }
    setState(() {
      sectionlist.clear();
    });
    var response = await BaseClient()
        .get(
            '/$endpoint/$_selectedDate',
            _authToken!,
            errTxt: 'can\'t load sections data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });
    if (response == null) return;
    final data = filteredProfissorSectionsModelFromJson(response);
    if (data.sections != null) {
      for (int i = 0; i < data.sections!.length; i++) {
        final sectionId = data.sections?[i].id;
        final sectionName =
            'Section: \n\t\t\t\t${data.sections?[i].subjectId?.name}';
        final sectionTime = data.sections == null
            ? null
            : DateFormat('H:mm a').format(data.sections![i].date);
        final personName =
            _authType == 'assistant' ? 'Eng. $_authName' : 'Dr. $_authName';

        setState(() {
          if (data.sections != null) {
            sectionlist.add(SectionData(
              secId: sectionId,
              secName: sectionName,
              secTime: sectionTime,
              userName: personName,
              visible: visible,
            ));
          }
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1) digital clock was here
                        Column(
                          children: const [
                            Text(
                              'Let\'s find \nYour next class!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        // 2) profile photo
                        const SizedBox(
                          height: 66.0,
                          width: 66.0,
                          child: UserPhoto(
                            img: 'images/user1.png',
                            rounded: false,
                          ),
                        ),
                      ],
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
                      initialSelectedDate: DateTime.now(),
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
                            height: 210.0,
                            child: Center(
                              child: TabBarView(children: [
                                ClassesTab(lecture: _filteredData),
                                SectionsTab(sections: sectionlist),
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
