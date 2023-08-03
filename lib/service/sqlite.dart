

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/news/article.dart';

class DatabaseHelper {
  static const String tableArticles = 'articles';
  static const String columnId = 'id';
  static const String columnSource = 'source';
  static const String columnAuthor = 'author';
  static const String columnTitle = 'title';
  static const String columnDescription = 'description';
  static const String columnUrl = 'url';
  static const String columnUrlToImage = 'urlToImage';
  static const String columnPublishedAt = 'publishedAt';
  static const String columnContent = 'content';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'my_articles.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $tableArticles (
            $columnId INTEGER PRIMARY KEY,
            $columnSource TEXT,
            $columnAuthor TEXT,
            $columnTitle TEXT,
            $columnDescription TEXT,
            $columnUrl TEXT,
            $columnUrlToImage TEXT,
            $columnPublishedAt TEXT,
            $columnContent TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertArticle(Article article) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> result = await db.query(
      tableArticles,
      where: '$columnUrl = ?',
      whereArgs: [article.url],
      limit: 1,
    );

    if (result.isEmpty) {
      await db.insert(tableArticles, article.toJson());
    }
  }

  Future<List<Article>> getArticles() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableArticles);
    return List.generate(maps.length, (i) {
      final Map<String, dynamic> json = Map<String, dynamic>.from(maps[i]);
      if (json['source'] is String) {
        json['source'] = {'name': json['source']};
      }
      return Article.fromJson(json);
    });
  }

  Future<void> deleteArticle(Article article) async {
    final db = await instance.database;
    await db.delete(
      tableArticles,
      where: '$columnUrl = ?',
      whereArgs: [article.url],
    );
  }

  Future<void> deleteAllArticles() async {
    final db = await instance.database;
    await db.delete(tableArticles);
  }
}
