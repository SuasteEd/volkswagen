import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStorePiezas {
  final CollectionReference _piezaCollection =
      FirebaseFirestore.instance.collection('piezas');
  Stream<QuerySnapshot<Object?>> getAllHerramientas() {
    return _piezaCollection.where("tipo", isEqualTo: 1).snapshots();
  }

  Stream<QuerySnapshot<Object?>> getAllMaterial() {
    return _piezaCollection.where("tipo", isEqualTo: 0).snapshots();
  }

  Stream<DocumentSnapshot<Object?>> get(String id) {
    return _piezaCollection.doc(id).snapshots();
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
