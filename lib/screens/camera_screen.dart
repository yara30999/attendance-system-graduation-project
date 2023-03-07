import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  static String id = 'camera_screen';

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
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
    for (var img in imageFileList) {
      String filepath = File(img.path).toString();
      print('the image $img path is  $filepath');
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
                                File(imageFileList[index].path),
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
                onPressed: () {},
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
