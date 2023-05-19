import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirmar', style: TextStyle(color: Colors.black)),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Slidable(
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Aceptado')),
                            );
                          },
                          label: 'Recibido',
                          backgroundColor: Colors.green,
                          icon: Icons.check,
                        ),
                      ],
                    ),
                    endActionPane:
                        ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Rechazado')),
                          );
                        },
                        label: 'Reportar',
                        backgroundColor: Colors.red,
                        icon: Icons.close,
                      ),
                    ]),
                    child: ListTile(
                      title: Text('dato'),
                    )),
              ))
            ],
          ),
        ));
  }
}
