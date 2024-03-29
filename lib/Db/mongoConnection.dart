import "package:mongo_dart/mongo_dart.dart";
import "package:petfindr/Db/dbConstants.dart";

class MongoDatabase {
  static var db, userCollection, reportCollection;
  static connect() async {
    try {
      db = await Db.create(DB_URL);
      await db.open();
      userCollection = db.collection(USERS_COLLECTION);
      reportCollection = db.collection(REPORTS_COLLECTION);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<Map<String, dynamic>> loginUser(
      String email, String pass) async {
    try {
      var result = await userCollection.findOne(where.eq("email", email));
      if (result != null) {
        return {'code': 200, 'data': result};
      } else {
        return {'code': 404, 'error': "No User Found"};
      }
    } catch (e) {
      return {'code': 500, 'error': e.toString()};
    }
  }

  static Future<List<dynamic>?> fetchReports() async {
    try {
      var reports = [];
      await reportCollection.find().forEach((rep) {
        reports.add(rep);
      });
      return reports;
    } catch (e) {
      return null;
    }
  }
}
