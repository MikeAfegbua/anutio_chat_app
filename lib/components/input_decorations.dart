import 'package:flutter/material.dart';

// INPUT DECORATION FOR TEXTFIELD
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your val',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

abstract interface class BaseService {
  Future<void> login() async {}
}

class FirebaseService extends BaseService {
  @override
  Future<void> login() async {}
}

class RESTApiService extends BaseService {
  @override
  Future<void> login() async {}
}
