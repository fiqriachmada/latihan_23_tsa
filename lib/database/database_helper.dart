import 'package:flutter/material.dart';
import 'package:latihan_23_tsa/model/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  final String tableName = 'tableContact';
  final String columnId = 'columnId';
  final String columnName = 'columnName';
  final String columnMobileNumber = 'columnMobileNumber';
  final String columnEmail = 'columnEmail';
  final String columnCompany = 'columnCompany';

  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();

    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'contact.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = 'CREATE TABLE $tableName($columnId INTERGER PRIMARY KEY, '
        '$columnName TEXT,';
    '$columnMobileNumber TEXT,';
    '$columnEmail TEXT,';
    '$columnCompany TEXT)';
    await db.execute(sql);
  }

  Future<int?> saveContact(Contact contact) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, contact.toMap());
  }

  Future<List?> getAllContact() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnMobileNumber,
      columnEmail,
      columnCompany,
    ]);

    return result.toList();
  }

  Future<int?> updateContact(Contact contact) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future<int?> deleteContact(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
