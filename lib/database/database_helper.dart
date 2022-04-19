// ignore_for_file: unused_field
import 'dart:io';

import 'package:bunsep/models/cake.dart';
import 'package:bunsep/models/category.dart';
import 'package:bunsep/models/db_model.dart';
import 'package:bunsep/models/receipt.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    String dir = await getDatabasesPath();
    String path = join(dir, DBModel.DB_NAME);
    ByteData data = await rootBundle.load('lib/database/bunsep.db');
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
    return await openDatabase(path);
  }

  // todo: get Category
  Future<List<Category>> getCategories() async {
    Database database = await instance.database;
    List<Map<String, dynamic>> categories =
        await database.query(DBModel.TABLE_CATEGORY, orderBy: 'category_id');
    List<Category> categoryList = categories.isNotEmpty
        ? categories.map((e) => Category.fromMap(e)).toList()
        : [];
    return categoryList;
  }

  // todo: get Cake
  Future<List<Cake>> getCakes() async {
    Database database = await instance.database;
    List<Map<String, dynamic>> cakes =
        await database.query(DBModel.TABLE_CAKE, orderBy: 'cake_id');
    List<Cake> cakeList =
        cakes.isNotEmpty ? cakes.map((e) => Cake.fromMap(e)).toList() : [];
    return cakeList;
  }

  // todo: get Receipt
  Future<List<Receipt>> getReceipt() async {
    Database database = await instance.database;
    List<Map<String, dynamic>> receipts =
        await database.query(DBModel.TABLE_RECEIPT, orderBy: 'receipt_id');
    List<Receipt> receiptList = receipts.isNotEmpty
        ? receipts.map((e) => Receipt.fromMap(e)).toList()
        : [];
    return receiptList;
  }

  // todo: get Receipt by Cake
  Future<List<Receipt>> getReceiptByID(Cake cake) async {
    Database database = await instance.database;
    List<Map<String, dynamic>> receipts = await database.query(
      DBModel.TABLE_RECEIPT,
      where: 'receipt_cake = ?',
      whereArgs: [cake.cake_id],
    );
    List<Receipt> receiptResult = receipts.isNotEmpty
        ? receipts.map((e) => Receipt.fromMap(e)).toList()
        : [];
    return receiptResult;
  }
}
