import 'package:flutter/material.dart';
import '../componant/classes_tab.dart';
import '../componant/sections_tab.dart';
import '../componant/user_photo.dart';
import '../constants.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../componant/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedDate; // for the calendar

// <<<1>>>>  from here ......................................
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grapes',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Quince',
    'Raspberry',
    'Strawberry',
    'Tomato',
    'Ugli fruit',
    'Vineapple',
    'Watermelon',
    'Xigua',
    'Yellow passion fruit',
    'Zucchini',
  ];
  List<String> _filteredData = [];

  void _updateFilteredData(String searchTerm) {
    setState(() {
      _filteredData = _data
          .where(
              (item) => item.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
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
                      children: [
                        // 1) digital clock
                        kDigitalClockStyle,
                        // 2) profile photo
                        const UserPhoto(
                          img: 'images/user1.png',
                          rounded: false,
                        ),
                      ],
                    ),
                    //const SizedBox(height: 10.0),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                    // const SizedBox(height: 12.0),
                    const Text(
                      'Let\'s find',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Your next class!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    // const SizedBox(height: 10.0),
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
                          _filteredData = _data;
                          _searchController.clear();
                        });
                        // Perform clear search logic here
                        // e.g., reset search results, etc.
                      },
                      searchController: _searchController,
                      box: SizedBox(
                        //to display the list of filterd data
                        height: 70,
                        child: ListView.builder(
                          itemCount: _filteredData.length,
                          itemBuilder: (context, index) => Container(
                            color: Colors.grey,
                            child: Text(
                              _filteredData[index],
                            ),
                          ),
                        ),
                      ),
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text(
                    //       'Date',
                    //       style: TextStyle(
                    //         fontSize: 18.0,
                    //         fontFamily: 'poppins',
                    //         fontWeight: FontWeight.w500,
                    //         color: Color(0xff263257),
                    //       ),
                    //     ),
                    //     //TODO // disply current month here
                    //     Text(
                    //       '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                    //       style: const TextStyle(
                    //         fontSize: 15.0,
                    //         fontFamily: 'poppins',
                    //         fontWeight: FontWeight.w500,
                    //         color: Color(0xff8A96BC),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    DatePicker(
                      DateTime.now(),
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
                          _selectedDate = selectedDate.day;
                          print(_selectedDate);
                        });
                      },
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: const [
                          SizedBox(
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
                            height: 150.0,
                            child: Center(
                              child: TabBarView(children: [
                                ClassesTab(),
                                SectionsTab(),
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
