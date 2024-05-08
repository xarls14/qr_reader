import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //Asignar el ID de la base de datos al modelo
    nuevoScan.id = id;

    if(tipoSeleccionado == nuevoScan.tipo){
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScans() async{
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...?scans];
    notifyListeners();
  }

  cargarScanPorTipo(String tipo) async{
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...?scans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async{
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async{
    await DBProvider.db.deleteScan(id);
    //cargarScanPorTipo(tipoSeleccionado);
  }

}