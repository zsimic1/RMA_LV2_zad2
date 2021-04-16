import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lista_poznatih/model/inspiringPerson.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_poznatih/main.dart';

class newPerson extends StatefulWidget {
  @override
  _newPersonState createState() => _newPersonState();
}

class _newPersonState extends State<newPerson> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController dayController = new TextEditingController();
  TextEditingController monthController = new TextEditingController();
  TextEditingController yearController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController quote1Controller = new TextEditingController();
  TextEditingController quote2Controller = new TextEditingController();
  TextEditingController quote3Controller = new TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
        title: Text('Add new person'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter persons name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Row(
                children: [
                  SizedBox(width: 5),
                  Flexible(child: Text('Enter birth date')),
                  SizedBox(width: 5),
                  Flexible(
                    child: TextField(
                      controller: dayController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'DD'),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: monthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'MM'),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: yearController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'YYYY'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: TextField(
                maxLength: 216,
                controller: descriptionController,
                decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    hintText: 'Enter description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: TextField(
                controller: quote1Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter quote 1'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: TextField(
                controller: quote2Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter quote 2'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: TextField(
                controller: quote3Controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter quote 3'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: Text('Upload image'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
          if (nameController.text.isNotEmpty &&
              descriptionController.text.isNotEmpty &&
              quote1Controller.text.isNotEmpty &&
              quote2Controller.text.isNotEmpty &&
              quote3Controller.text.isNotEmpty &&
              _image != null) {
            repository.addPerson(InspiringPerson(
                nameController.text,
                '${dayController.text}/${monthController.text}/${yearController.text}',
                descriptionController.text,
                [
                  quote1Controller.text,
                  quote2Controller.text,
                  quote3Controller.text
                ],
                _image));

            final snackBar = SnackBar(content: Text('Person added'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar =
                SnackBar(content: Text('All fields must be entered'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }
          nameController.clear();
          descriptionController.clear();
          quote1Controller.clear();
          quote2Controller.clear();
          quote3Controller.clear();
        },
        child: Text('Add'),
      ),
    );
  }
}
