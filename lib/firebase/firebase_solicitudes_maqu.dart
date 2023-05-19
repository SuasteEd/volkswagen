import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreSolicitudesMaq {
  final CollectionReference _solicitudCollection =
      FirebaseFirestore.instance.collection('solicitudes_maquinas');
  Future<bool> create(String problema, String celulaSolicitud,
      String comentarios, String idMaquina) async {
    try {
      _solicitudCollection.add({
        "problema": problema,
        "celula_solicitud": celulaSolicitud,
        "comentarios": comentarios,
        "estatus": 0,
        "id_maquina": idMaquina,
        "id_teamlead": "1",
        "solicitud_at": FieldValue.serverTimestamp()
      });
    } catch (ex) {}
    return false;
  }

  Stream<QuerySnapshot<Object?>> getAllonProces() {
    return _solicitudCollection.where("estatus", isEqualTo: 0).snapshots();
  }

  recibirSolicitur(String id) {
    _solicitudCollection
        .doc(id)
        .update({"estatus": 1, "result_at": FieldValue.serverTimestamp()});
  }

  reportarSolicitud(String id, String comentarios) {
    _solicitudCollection
        .doc(id)
        .update({"estatus": 2, "comentarios": comentarios});
  }

  Stream<DocumentSnapshot<Object?>> get(String id) {
    return _solicitudCollection.doc(id).snapshots();
  }
  /*get mensajes {
    return chatCollection
        .doc(userid)
        .collection('mensajes')
        .where('visto', isEqualTo: 0)
        .where('emisor', isEqualTo: 'v')
        .snapshots();
  }*/

  //////////////////////////////
}
