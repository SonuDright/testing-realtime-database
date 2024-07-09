import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeTestImageUpload extends StatefulWidget {
  const HomeTestImageUpload.TestImagePicHomeCreen({Key? key}) : super(key: key);
  @override
  State<HomeTestImageUpload> createState() => _HomeTestImageUploadState();
}
class _HomeTestImageUploadState extends State<HomeTestImageUpload> {
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
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
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

    var imageUpload = FirebaseStorage.instance.ref("profile").child("picker");
    await imageUpload.putFile(imageFile!,SettableMetadata(contentType: "image/png"));
    final String downloadUrl = await imageUpload.getDownloadURL();
    print("Image upliad. DownLoad Url $downloadUrl");

    storeLink(downloadUrl);
    setState(() {

    });

  }
  storeLink(Stringurl)async{
    await FirebaseFirestore.instance.collection("studentName").doc("").update({
    });

  }
}


