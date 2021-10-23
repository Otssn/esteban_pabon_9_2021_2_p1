import 'package:connectivity/connectivity.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_app/components/loader_component.dart';
import 'package:harry_potter_app/helpers/api_helper.dart';
import 'package:harry_potter_app/models/character.dart';
import 'package:harry_potter_app/models/response.dart';
import 'package:harry_potter_app/screen/error_screen.dart';
import 'package:harry_potter_app/screen/wizars_screen.dart';

class ListCharacterScreen extends StatefulWidget {
  const ListCharacterScreen({Key? key}) : super(key: key);

  @override
  _ListCharacterScreenState createState() => _ListCharacterScreenState();
}

class _ListCharacterScreenState extends State<ListCharacterScreen> {
  bool _isLoading = false;
  bool _isFiltered = false;
  List<character> _character = [];
  String _search = "";

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
        title: Text(
          'Harry Potter characters',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: removeFilter,
                  icon: Icon(Icons.filter_none),
                )
              : IconButton(
                  onPressed: _showFilter,
                  icon: Icon(Icons.filter_alt),
                ),
        ],
        backgroundColor: Colors.red[100],
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
    var cocnectcityResult = await Connectivity().checkConnectivity();

    if (cocnectcityResult == ConnectivityResult.none) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ErrorScreen()));
      return;
    }
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
            color: Colors.yellow.shade200,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WizardScreen(
                            char: e,
                          )),
                );
              },
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
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getCharacter();
  }

  void _showFilter() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text('Filtrar nombre'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Escriba las primeras letras del nombre'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Criterio de busqueda',
                    labelText: 'Buscar',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _search = value;
                    });
                  },
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              TextButton(onPressed: () => _filter(), child: Text('Filtrar'))
            ],
          );
        });
  }

  _filter() {
    if (_search.isEmpty) {
      return;
    }
    List<character> filterList = [];
    for (var item in _character) {
      if (item.name.toLowerCase().contains(_search.toLowerCase())) {
        filterList.add(item);
      }
    }
    setState(() {
      _character = filterList;
      _isFiltered = true;
    });
    Navigator.of(context).pop();
  }
}
