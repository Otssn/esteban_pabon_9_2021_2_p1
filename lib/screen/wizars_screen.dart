import 'package:flutter/material.dart';
import 'package:harry_potter_app/components/loader_component.dart';
import 'package:harry_potter_app/models/character.dart';
import 'package:harry_potter_app/screen/list_character_screen.dart';

class WizardScreen extends StatefulWidget {
  final character char;
  WizardScreen({required this.char});

  @override
  _WizardScreenState createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  bool _showLoader = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _SpeciesController = TextEditingController();
  TextEditingController _GenderController = TextEditingController();
  TextEditingController _HouseController = TextEditingController();
  TextEditingController _DateBirthController = TextEditingController();
  TextEditingController _YearController = TextEditingController();
  TextEditingController _WizarController = TextEditingController();
  TextEditingController _AncestyController = TextEditingController();
  TextEditingController _EyeController = TextEditingController();
  TextEditingController _HairController = TextEditingController();
  TextEditingController _PatronusController = TextEditingController();
  TextEditingController _StudentController = TextEditingController();
  TextEditingController _StaffController = TextEditingController();
  TextEditingController _ActorNameController = TextEditingController();
  TextEditingController _AliveController = TextEditingController();
  TextEditingController _AltController = TextEditingController();

  TextEditingController _AltActorController = TextEditingController();

  TextEditingController _WoodController = TextEditingController();
  TextEditingController _CoreController = TextEditingController();
  TextEditingController _LengthController = TextEditingController();

  Color colorRgb = Color.fromRGBO(238, 186, 48, 1);
  Color colorRgbBack = Color.fromRGBO(255, 255, 255, 1);
  @override
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.char.name;
    _SpeciesController.text = widget.char.species;
    _GenderController.text = widget.char.gender;
    _HouseController.text = widget.char.house;
    _DateBirthController.text = widget.char.dateOfBirth;
    _YearController.text = widget.char.yearOfBirth.toString();
    _WizarController.text =
        widget.char.wizard ? "Is wizard :)" : "Is´n wizard :(";
    _AncestyController.text = widget.char.ancestry;
    _EyeController.text = widget.char.eyeColour;
    _HairController.text = widget.char.hairColour;
    _PatronusController.text = widget.char.patronus;
    _StudentController.text = widget.char.hogwartsStudent
        ? "Study in Hogwart :)"
        : "Not study in Howgwart :(";
    _StaffController.text = widget.char.hogwartsStaff
        ? "Word in Hogwart :)"
        : "Not Word in Hogwart :(";
    ;
    _ActorNameController.text = widget.char.actor;
    _AliveController.text = widget.char.alive ? "Alive :)" : "Death :(";
    _ActorNameController.text = widget.char.alternateNames.toString();
    _AltActorController.text = widget.char.alternateActors.toString();

    _WoodController.text = widget.char.wand.wood;
    _CoreController.text = widget.char.wand.core;
    _LengthController.text = widget.char.wand.length.toString();

    switch (widget.char.house.toLowerCase()) {
      case "gryffindor":
        colorRgb = Color.fromRGBO(174, 0, 1, 20);
        colorRgbBack = Color.fromRGBO(238, 186, 48, 1);
        break;
      case "slytherin":
        colorRgb = Color.fromRGBO(26, 71, 42, 1);
        colorRgbBack = Color.fromRGBO(170, 170, 170, 1);
        break;
      case "ravenclaw":
        colorRgb = Color.fromRGBO(34, 47, 91, 1);
        colorRgbBack = Color.fromRGBO(93, 93, 93, 1);
        break;
      case "hufflepuff":
        colorRgb = Color.fromRGBO(255, 237, 134, 1);
        colorRgbBack = Color.fromRGBO(96, 96, 92, 1);
        break;
      default:
        colorRgb = Color.fromRGBO(238, 186, 48, 1);
        colorRgbBack = Color.fromRGBO(255, 255, 255, 1);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.char.name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: colorRgb,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ListCharacterScreen()),
            );
          },
          color: Colors.black,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: colorRgbBack,
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _showPhoto(),
                  _showName(),
                  _showAltName(),
                  _showSpecies(),
                  _showGender(),
                  _showHouse(),
                  _showDateBirth(),
                  _showYear(),
                  _showWizard(),
                  _showAncestry(),
                  _showEyeColor(),
                  _showHairColor(),
                  _showWand(),
                  _showPatronus(),
                  _showHogwartStudent(),
                  _showHogwartStaff(),
                  _showActor(),
                  _showAltActor(),
                  _showAlive(),
                ],
              ),
            ),
            _showLoader
                ? loaderComponents(
                    text: 'Por favor espere',
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _showPhoto() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: FadeInImage(
              placeholder: AssetImage('assets/logo.png'),
              image: NetworkImage(widget.char.image),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showName() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _nameController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Name',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showAltName() {
    TextEditingController _AltController = TextEditingController();
    print(widget.char.alternateNames);
    if (widget.char.alternateNames.length == 1) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _AltController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Alternative Name',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showSpecies() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _SpeciesController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Species',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showGender() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _GenderController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Gender',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showHouse() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _HouseController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'House',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showDateBirth() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _DateBirthController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Date of birth',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showYear() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _YearController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Year of birth',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showWizard() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _WizarController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Wizard',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showAncestry() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _AncestyController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Ancestry',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showEyeColor() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _EyeController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Eye of color',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showHairColor() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _HairController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Hair of color',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showWand() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Wand"),
          TextField(
            enabled: false,
            controller: _WoodController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'Wood',
              suffixIcon: Icon(Icons.description),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextField(
            enabled: false,
            controller: _CoreController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'Core',
              suffixIcon: Icon(Icons.description),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextField(
            enabled: false,
            controller: _LengthController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'Length',
              suffixIcon: Icon(Icons.description),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showPatronus() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _PatronusController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Patronus',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showHogwartStudent() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _StudentController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Howgart student',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showHogwartStaff() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _StaffController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Howgart staff',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showActor() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _ActorNameController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Actor',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showAltActor() {
    if (widget.char.alternateActors.length == 1) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _AltActorController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Alternative Actor',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _showAlive() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        enabled: false,
        controller: _AliveController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Alive',
          suffixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
