import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lista_poznatih/model/PeopleRepository.dart';
import 'package:lista_poznatih/screens/addNewPerson.dart';

void main() => runApp(MaterialApp(home: Lists()));

class Lists extends StatefulWidget {
  @override
  _ListsState createState() => new _ListsState();
}

final repository = new PeopleRepository();

class _ListsState extends State<Lists> {

  ShowAlertDialog(BuildContext context, int index) {

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },

    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        setState(() {
          repository.removePerson(index);
          Navigator.of(context).pop();
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Selected item will be deleted"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Famous people in IT'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: repository.people.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {

                ShowAlertDialog(context, index);

              },
              onTap: () {
                final snackBar = SnackBar(
                    content: Text(
                        repository.people[index].quotes[Random().nextInt(3)]),
                    duration: const Duration(milliseconds: 700));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Container(
                  color: Colors.blue[400],
                  height: 180,
                  padding: const EdgeInsets.all(5),
                  child: Row(children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    FileImage(repository.people[index].photo),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 14,
                      child: Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(repository.people[index].name,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 5),
                            Text(repository.people[index].dateOfBirth,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    repository.people[index].description,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Text('New'),
        onPressed: () async {
          final value = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => newPerson()));
          setState(() {});
        },
      ),
    );
  }
}
