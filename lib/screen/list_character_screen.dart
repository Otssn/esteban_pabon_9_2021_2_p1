import 'package:connectivity/connectivity.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_app/components/loader_component.dart';
import 'package:harry_potter_app/helpers/api_helper.dart';
import 'package:harry_potter_app/models/character.dart';
import 'package:harry_potter_app/models/response.dart';

class ListCharacterScreen extends StatefulWidget {
  const ListCharacterScreen({Key? key}) : super(key: key);

  @override
  _ListCharacterScreenState createState() => _ListCharacterScreenState();
}

class _ListCharacterScreenState extends State<ListCharacterScreen> {
  bool _isLoading = false;
  bool _connectivity = true;
  bool _isFiltered = false;
  List<character> _character = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harry Potter characters'),
      ),
      body: Center(
        child: _isLoading
            ? loaderComponents(text: "Por favor espere")
            : _getContend(),
      ),
    );
  }

  _getContend() {
    return _character.length == 0 ? _notContent() : _getListView();
  }

  Future<Null> _getCharacter() async {
    setState(() {
      _isLoading = true;
    });
    Responses responses = await ApiHelper.getCharacters();

    if (!responses.isSuccess) {
      await showAlertDialog(
        context: context,
        title: 'Error',
        message: responses.messaje,
        actions: <AlertDialogAction>[
          AlertDialogAction(key: null, label: 'Aceptar')
        ],
      );
    }
    setState(() {
      _character = responses.result;
    });
    setState(() {
      _isLoading = false;
    });
  }

  Widget _notContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          _isFiltered
              ? 'No hay personajes con este criterio'
              : 'No hay personajes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getCharacter,
      child: ListView(
        children: _character.map((e) {
          return Card(
            child: InkWell(
              onTap: () => {},
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/logo.png'),
                        image: NetworkImage(e.image),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                e.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                e.species,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                e.patronus,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
