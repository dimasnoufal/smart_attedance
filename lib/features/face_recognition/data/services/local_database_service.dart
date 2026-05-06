import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:smart_attedance/features/face_recognition/domain/entities/user_embedding_entity.dart';

@lazySingleton
class LocalDatabaseService {
  static const String _tableName = 'face_embeddings';
  static const String _colUserId = 'user_id';
  static const String _colName = 'name';
  static const String _colEmbedding = 'embedding';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'smart_attendance.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_colUserId TEXT PRIMARY KEY,
            $_colName TEXT DEFAULT '',
            $_colEmbedding TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE $_tableName ADD COLUMN $_colName TEXT DEFAULT ''",
          );
        }
      },
    );
  }

  /// Upserts (inserts or updates) a user embedding.
  /// Converts the 512 List<double> into a JSON string for SQLite storage.
  Future<void> upsertEmbedding(UserEmbeddingEntity entity) async {
    final db = await database;
    await db.insert(_tableName, {
      _colUserId: entity.userId,
      _colName: entity.name,
      _colEmbedding: jsonEncode(entity.embedding),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Deletes a user embedding by user_id.
  Future<void> deleteEmbedding(String userId) async {
    final db = await database;
    await db.delete(_tableName, where: '$_colUserId = ?', whereArgs: [userId]);
  }

  /// Retrieves all stored embeddings.
  /// Parses the JSON string back into a 512 List<double>.
  Future<List<UserEmbeddingEntity>> getAllEmbeddings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      final String jsonStr = maps[i][_colEmbedding] as String;
      final List<dynamic> jsonList = jsonDecode(jsonStr);
      final List<double> embedding = jsonList
          .map((e) => (e as num).toDouble())
          .toList();

      return UserEmbeddingEntity(
        userId: maps[i][_colUserId] as String,
        name: (maps[i][_colName] as String?) ?? '',
        embedding: embedding,
      );
    });
  }

  /// Clears the entire table.
  Future<void> clearAll() async {
    final db = await database;
    await db.delete(_tableName);
  }
}
