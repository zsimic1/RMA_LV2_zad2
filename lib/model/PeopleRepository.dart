
import 'package:lista_poznatih/model/inspiringPerson.dart';

class PeopleRepository{

  List<InspiringPerson> people;

  PeopleRepository()
  {
    this.people = [];
  }

  void addPerson(InspiringPerson person){ people.add(person);}
  void removePerson(int index) {people.removeAt(index);}


}