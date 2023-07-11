import 'dart:convert';
// import 'dart:html';

import 'package:dio/dio.dart';
//import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import '../componant/appbar_custom.dart';
import '../models/auth_state.dart';
import '../services/base_client.dart';
import 'attendance_list.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  static String id = 'camera_screen';

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late String meetingId;
  late String meetingName;
  String? _authToken;
  String? _authType;
  String? _authId;
  String? _regToken;
  late bool _isLoaded;

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

  navMethod() {
    Navigator.pushNamed(
      context,
      AttendanceListScreen.id,
      arguments: {
        'lectureId': meetingId,
        'lectureName': meetingName,
      },
    );
  }

  List<XFile> imageFileList = [];

  final ImagePicker imagePicker = ImagePicker();

  void addSelectedImages() async {
    try {
      //3)) using your method of getting an image
      final XFile? selectedImage =
          await imagePicker.pickImage(source: ImageSource.camera);

      imageFileList.add(selectedImage!);

      setState(() {
        imageFileList = imageFileList;
      });
      printInfoList();
    } catch (e) {
      print('faild to pick img $e ');
    }
  }

  void removeSelectedImage(XFile imageFile) {
    imageFileList.remove(imageFile);
    setState(() {
      imageFileList = imageFileList;
    });
    printInfoList();
  }

  void printInfoList() {
    print('Image list length ${imageFileList.length}');
    print('the image file list is : $imageFileList');
    // print('the image file list is : ${json.encode(imageFileList)}');
    for (var img in imageFileList) {
      String filepath = io.File(img.path).toString();
      print('the image $img path is  $filepath');
    }
  }

  @override
  void initState() {
    super.initState();
    loadToken();
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
    meetingId = args['lectureId'];
    meetingName = args['lectureName'];
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
  }

  //not used because it always give a null response...
  Future<void> sendImagesToBackend(List<XFile> imageFileList) async {
    if (imageFileList.isEmpty) {
      showError('You have to take a photo first... ');
    } else if (imageFileList.length >= 4) {
      showError('You can only upload 3 photos... ');
    } else {
      final String endpoint;
      final String myPath;
      final String subjectName = meetingName.split('\t').last.toLowerCase();
      if (_authType == 'professor') {
        endpoint = '/attendance/$meetingId';
        myPath = '$subjectName/lecture';
        print(endpoint);
        print(myPath);
      } else {
        endpoint = '/section-attendance/$meetingId';
        myPath = '$subjectName/section';
        print(endpoint);
        print(myPath);
      }

      final url = baseUrl + endpoint;
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $_authToken';
      dio.options.headers['content-type'] = 'multipart/form-data';
      dio.options.headers['path'] = myPath;

      final formData = FormData();
      //formData.fields.add(MapEntry('path', myPath));

      for (var i = 0; i < imageFileList.length; i++) {
        final image = imageFileList[i];
        final fileName = image.path.split('/').last;
        print('fileName: $fileName');
        formData.files.add(MapEntry(
          'images', //key
          await MultipartFile.fromFile(
            image.path,
            filename: 'image$i.png',
            contentType: MediaType('png', 'jpg'),
          ),
        ));
      }
      var response;
      try {
        response = await dio.post(
          url,
          data: formData,
        );
        if (response.statusCode == 200) {
          print('Images uploaded successfully');
        } else if (response.statusCode == 500) {
          //print(response);
          // print(response.statusCode);
          // print(response.data);
          // print(response.statusMessage);
        } else {
          print('Failed to upload images. Status code: ${response.statusCode}');
          showError('Can\'t Send the images to the AI model ... ');
          throw Exception('Failed to make post request for camera ==> yara:-)');
        }
      } catch (e) {
        // e.toString()

        print('response yyy: ${json.encode(response)}');
        // print('response.statusCode yyy: ${response.statusCode}');
        // print('response.data yyy: ${response.data}');
        // print('response.statusMessage yyyy: ${response.statusMessage}');
        showError(e.toString());
      }
    }
  }

  Future<void> sendImagesToBackend2(List<XFile> imageFileList) async {
    if (imageFileList.isEmpty) {
      showError('You have to take a photo first... ');
    } else if (imageFileList.length >= 4) {
      showError('You can only upload 3 photos... ');
    } else {
      final String endpoint;
      final String myPath;
      final String subjectName = meetingName.split('\t').last.toLowerCase();
      if (_authType == 'professor') {
        endpoint = '/attendance/$meetingId?deviceToken=${_regToken!}';
        myPath = '$subjectName/lecture';
        print(endpoint);
        print(myPath);
      } else {
        endpoint = '/section-attendance/$meetingId?deviceToken=${_regToken!}';
        myPath = '$subjectName/section';
        print(endpoint);
        print(myPath);
      }
      final url = Uri.parse(baseUrl + endpoint);

      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $_authToken';
      request.headers['content-type'] = 'multipart/form-data';
      request.headers['path'] = myPath;

      for (var i = 0; i < imageFileList.length; i++) {
        final image = imageFileList[i];
        final fileName = image.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          image.path,
          filename: 'img$i.png',
          contentType: MediaType('image', 'png'),
        ));
      }
      var response;
      try {
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode == 200) {
          print('Images uploaded successfully');
          await navMethod();
        } else if (response.statusCode == 500) {
          print(response.statusCode);
          print(response.body);
        } else {
          print('Failed to upload images. Status code: ${response.statusCode}');
          showError('Can\'t Send the images to the AI model ... ');
          throw Exception('Failed to make post request for camera ==> yara:-)');
        }
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppbarCustom(
              label: '',
              onpress: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // build selected image card...
                child: ListView.builder(
                    // 1 >>> passing the length of the list to ListView.builder.
                    itemCount: imageFileList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 159, 160, 160)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0))),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
                              // 2 >>> convert the (instance of XFile) to (File).
                              // to display the file as image...
                              child: Image.file(
                                io.File(imageFileList[index].path),
                                height: 200.0,
                                width: 310.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // 3 >>> to delete instance of XFile from the list.
                            IconButton(
                              onPressed: () {
                                removeSelectedImage(imageFileList[index]);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            // tne (next arrow) in the bottom....
            Container(
              height: 40.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.black26),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromARGB(255, 197, 196, 196),
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () async {
                  try {
                    // await sendImagesToBackend(imageFileList);
                    await sendImagesToBackend2(imageFileList);
                  } catch (e) {
                    // Handle any error that occurs during the upload
                    print('Error occurred during image upload: $e');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'next',
                      style: TextStyle(color: Color(0xff263257)),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: Color(0xff263257),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addSelectedImages();
        },
        backgroundColor: Colors.white,
        elevation: 8.0,
        child: const Icon(Icons.add_a_photo, color: Color(0xff263257)),
      ),
    );
  }
}
