import 'package:fast_tende_doctor_app/screens_student/second_screen.dart';
import 'package:flutter/material.dart';
import '../models/p_student_model.dart';
import '../models/auth_state.dart';
import '../services/base_client.dart';
import '../services/signin_or_out.dart';

class STDProfileScreen extends StatefulWidget {
  const STDProfileScreen({super.key});
  static String id = 'std_prifile_screen';

  @override
  State<STDProfileScreen> createState() => _STDProfileScreenState();
}

class _STDProfileScreenState extends State<STDProfileScreen> {
  String? _authToken;
  String? _authType;
  String? _authId;
  late bool _isLoaded;
  late String name;
  late String email;
  late String id;
  late String phone;

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

  @override
  void initState() {
    super.initState();
    loadToken();
    // fetchProfileData();
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
    //////////////////////////////////////////////////then get Id.
    await tokenState.getAuthId().then((value) {
      setState(() {
        _authId = value;
      });
    });
    print('my id $_authId');
    fetchProfileData();
  }

  void fetchProfileData() async {
    var response = await BaseClient()
        .get(
            '/student/$_authId',
            _authToken!,
            errTxt: 'can\'t load data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });
    if (response == null) return;
    debugPrint('successful:');
    setState(() {
      final data = studentModelFromJson(response);
      name = data.student!.name;
      email = data.student!.email;
      phone = data.student!.phoneNumber;
      id = data.student!.id;
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: const [
                // 1)) blue container...
                TopBlueContainer(),
                // 2)) user image....
                ProfilePhoto(
                  imgURL: 'images/user1.png',
                )
              ],
            ),
            const SizedBox(height: 70.0),
            InfoDisplay(
              icon: Icons.perm_identity_outlined,
              titleText: 'Name',
              subtitleText: _isLoaded ? name : 'loading',
            ),
            InfoDisplay(
              icon: Icons.email_outlined,
              titleText: 'Email Address',
              subtitleText: _isLoaded ? email : 'loading',
              fontSize: 15.0,
            ),
            const InfoDisplay(
              icon: Icons.description_outlined,
              titleText: 'ID-Number',
              subtitleText: '19195568',
            ),
            InfoDisplay(
              icon: Icons.phone_outlined,
              titleText: 'Mobile Number',
              subtitleText: _isLoaded ? phone : 'loading',
            ),
            const SizedBox(height: 10.0),
            LogoutButton(
              onPress: () {
                SignInOrOut().logout(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class TopBlueContainer extends StatelessWidget {
  const TopBlueContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff0D8AD5),
      height: 135.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SecondScreen.id);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 100.0),
          const Padding(
            padding: EdgeInsets.only(top: 7.0),
            child: Text('Profile',
                style: TextStyle(
                    letterSpacing: 0.6,
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key, required this.imgURL});
  final String imgURL;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 78.0,
      child: Card(
        shape: const CircleBorder(),
        elevation: 8.0,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 64.0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60.0,
            backgroundImage: AssetImage(imgURL),
          ),
        ),
      ),
    );
  }
}

class InfoDisplay extends StatelessWidget {
  const InfoDisplay(
      {super.key,
      required this.icon,
      required this.titleText,
      required this.subtitleText,
      this.fontSize = 18});
  final IconData? icon;
  final String titleText;
  final String subtitleText;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xff074E79),
                size: 30,
              ),
              const SizedBox(width: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titleText,
                    style: const TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 12,
                        color: Color(0xff0D8AD5)),
                  ),
                  Text(
                    subtitleText,
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: fontSize,
                        fontWeight: FontWeight.w100,
                        color: Colors.black),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.onPress});
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      constraints: const BoxConstraints.tightFor(width: 130.0, height: 35.0),
      elevation: 5.0,
      disabledElevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      fillColor: const Color(0xff0D8AD5),
      child: const Text(
        'Logout',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
