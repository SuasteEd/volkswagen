import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/quickalert.dart';
import 'package:team_prot1/firebase/firebase_piezas.dart';
import 'package:team_prot1/firebase/firebase_solicitudes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Tools(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Volkswagen',
            style: TextStyle(color: Colors.black),
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset('assets/logo.png', width: 200, height: 200),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text('Confirmar'),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    Navigator.of(context).pushNamed('second');
                  },
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ));
  }
}

class Tools extends StatelessWidget {
  const Tools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Center(
      child: Column(
        children: [
          Expanded(
              child: Container(
            //color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Maquinas'),
              ],
            ),
          )),
          Expanded(
            flex: 8,
            child: StreamBuilder(
                stream: FireStorePiezas().getAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text("No se pudo obtener información.");
                  if (!snapshot.hasData) return Container();
                  return ListView(
                      children: snapshot.data!.docs.map((e) {
                    return Card(
                      child: ListTile(
                        title: Text('Id: ${e.id}'),
                        subtitle: Text('${e["nombre"]}'),
                        leading: const Icon(Icons.build),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          var controller = TextEditingController();
                          QuickAlert.show(
                            context: context,
                            customAsset: 'assets/logo.png',
                            backgroundColor: Colors.black12,
                            // barrierDismissible: false,
                            confirmBtnText: 'Enviar',
                            title: e['nombre'],
                            type: QuickAlertType.warning,
                            text: 'Ingresa el problema a resolver',
                            widget: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingresa la cantidad que necesitas';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            onConfirmBtnTap: () async {
                              if (_formKey.currentState!.validate()) {
                                FireStoreSolicitudes()
                                    .create(controller.text, "1", "", e.id);
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                      ),
                    );
                  }).toList());
                }),
          ),
        ],
      ),
    );
  }
}
