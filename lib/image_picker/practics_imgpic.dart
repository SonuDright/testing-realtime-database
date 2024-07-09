import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeTestImageUploadPractics extends StatefulWidget {
  const HomeTestImageUploadPractics({Key? key}) : super(key: key);
  @override
  State<HomeTestImageUploadPractics> createState() => _HomeTestImageUploadPracticsState();
}
class _HomeTestImageUploadPracticsState extends State<HomeTestImageUploadPractics> {
  File? imageFile;
  showAlertBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ListTile(
                onTap: () {
                  pickImageFromCamara(ImageSource.camera);

                  Navigator.pop(context);

                },
                title: Text('Camera'),
                leading: Icon(Icons.camera_alt),

              ),
              ListTile(
                onTap: () {
                  pickImageFromGallarry();
                  Navigator.pop(context);
                },
                title: Text('Gallery'),
                leading: Icon(Icons.image),

              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
                child: imageFile == null ? Icon(Icons.person) : null,
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showAlertBox();
                },
                child: Text('Select Image'),
              ),
            ),
            SizedBox(height: 20,),

            Center(
              child: ElevatedButton(onPressed: () {
                upLoadImage();
              }, child: Text("UploadImage")),
            ),
          ],
        ),
      ),
    );
  }

  pickImageFromCamara(ImageSource source) async {

    var imgPath = await ImagePicker().pickImage(source: ImageSource.camera);
    imageFile = File(imgPath!.path);
    setState(() {

    });
  }

  pickImageFromGallarry()async{
    var imagePath = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(imagePath!.path);
    setState(() {
    });

  }

  upLoadImage()async{
    var fileName = DateTime.now().microsecondsSinceEpoch.toString();
    var imageUpload = FirebaseStorage.instance.ref("profile").child(fileName);
    await imageUpload.putFile(imageFile!,SettableMetadata(contentType: "image/png"));
    final String downloadUrl = await imageUpload.getDownloadURL();
    print("Image upliad. DownLoad Url $downloadUrl");
    storeLink(downloadUrl);
    setState(() {

    });

  }
  
  
  // imageUplod()async{
  //   var  upImg = FirebaseStorage.instance.ref("allprofile").child("folder");
  //   await upImg.putFile(imageFile!,SettableMetadata(contentType: "image/PNG"));
  //   final String  downlodeImage = await upImg.getDownloadURL();
  //   print("Image uplode url $downlodeImage");
  //
  //
  // }

  // storeLink(String url)async{
  //   await FirebaseFirestore.instance.collection("studentsName").doc("").update({
  //
  //   });
  // }
  
  
  storeLink(String url)async{
    await FirebaseFirestore.instance.collection("studentName").doc("").update({
    });

  }


}


