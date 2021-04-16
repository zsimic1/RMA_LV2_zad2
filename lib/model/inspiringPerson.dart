import 'dart:io';

class InspiringPerson {
  String name;
  String description;
  String dateOfBirth;
  List<String> quotes;
  File photo;

  InspiringPerson(name, dateOfBirth, description, quotes, photo) {
    this.name = name;
    this.dateOfBirth = dateOfBirth;
    this.description = description;
    this.quotes = quotes;
    this.photo = photo;
  }
}

//List<InspiringPerson> people = [];
