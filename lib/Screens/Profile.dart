import 'package:flutter/material.dart';
import 'dart:io';
import '../Logic/AppLocalization.dart';
import '../Components/Animation.dart';
import '../Components/RoundRectangleButton.dart';
import 'package:image_picker/image_picker.dart';
import '../Screens/Home.dart';

class Profile extends StatefulWidget {
  final String firstName;
  final String lastName;

  Profile({this.firstName, this.lastName});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _picker = ImagePicker();

  File _pictureFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 100),
              child: AnimationClass(
                  1.3,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalization.of(context).translate("label"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "${widget.firstName},${widget.lastName}!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )),
            ),
            AnimationClass(
              1.3,
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.only(left: 30, top: 2),
                        child: Text(
                          AppLocalization.of(context).translate("add"),
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        )),
                  ),
                ]),
              ),
            ),
            AnimationClass(
              1.3,
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 100,
                    child: ClipOval(
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: _pictureFile != null
                            ? Image.file(
                                _pictureFile,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  try {
                    final selectedImage =
                        await _picker.getImage(source: ImageSource.gallery);

                    if (selectedImage != null) {
                      setState(() {
                        _pictureFile = File(selectedImage.path);
                      });
                    } else {
                      print("No picture select");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
            SizedBox(
              height: 100,
            ),
            AnimationClass(
              1.3,
              RoundRectangleButton(
                  color: Colors.red,
                  elevation: 4.0,
                  height: 50.0,
                  text: _pictureFile == null
                      ? AppLocalization.of(context).translate("skip")
                      : AppLocalization.of(context).translate("next"),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  minWidth: MediaQuery.of(context).size.width / 2,
                  onPresss: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Home(
                              imagePath: _pictureFile,
                            )));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
