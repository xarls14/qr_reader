import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigationbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).borrarTodos();
            },
          )
        ],
      ),

      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {

  //Obtener el selected menu opt
  final uiProvider = Provider.of<UiProvider>(context);

  //Cambiar para mostrar la pagina respectiva
  final currentIndex = uiProvider.selectedMenuOpt;

  //TODO temporal leer la base de datos
  final tempScan = ScanModel(valor: 'http://google.com');
  //DBProvider.db.nuevoScan(tempScan);
  //DBProvider.db.getScanById(4).then((scan) => print(scan?.valor));
  //DBProvider.db.getTodosLosScans().then(print);
  //DBProvider.db.deleteAllScan().then(print);

  //usar scanListProvider
  final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

  switch(currentIndex){
    case 0:
      scanListProvider.cargarScanPorTipo('geo');
      return const MapasPage();

    case 1:
      scanListProvider.cargarScanPorTipo('http');
      return const DireccionesPage();


    default:
      return const MapasPage();
   }
  }
}