import 'package:connectivity/connectivity.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_app/components/loader_component.dart';

class ListCharacterScreen extends StatefulWidget {
  const ListCharacterScreen({Key? key}) : super(key: key);

  @override
  _ListCharacterScreenState createState() => _ListCharacterScreenState();
}

class _ListCharacterScreenState extends State<ListCharacterScreen> {
  bool _isLoading = false;
  bool _connectivity = true;
  bool _isFiltered = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harry Potter characters'),
      ),
      body: Center(
        child: _isLoading
            ? loaderComponents(text: "Por favot espere")
            : _getContend(),
      ),
    );
  }

  Future<Null> _Connection() async {
    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult == ConnectivityResult.none) {
      setState(() {
        _isLoading = false;
        _connectivity = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica tu conexion a internet',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Acerptar'),
          ]);
    }
  }

  _getContend() async {
    return _connectivity ? _getListView() : _notContent();
  }

  Widget _getListView() {
    return Container();
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
}
