
import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi{

  static const credentials = r'''
  {
  "type": "service_account",
  "project_id": "techstatic-410506",
  "private_key_id": "cbf0fed4f6a4ff9868a134e137628438b4983bb7",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCfx47suZY+UGER\nRskiEdY1jQ37znxMnVmDdBG7B5Qh+UxzOu7uP792pFgCo/+Aqr0gR1FmtkgGpz4f\nNEFEvtLnXDeAR6bIc8JG2awz8VZJawC4Yjad48T3htRyyhTbn8YkK7crB2gD3ajI\npjnqvcAp7GmjXHto/vOcx+SAKcjfS6qmFMNZWrwc9CVnx4NLekXXQuVDmEt8sKrf\nME2y5qXstsgUnaFqeWm/wG0slgG5EZaUvmsPLRhnGoXIY5f3s/R+Qguyvi6q1jH/\nTuNJo4h36h6a9X5VOwUFjr1KQTKOwajL6J1MvopPJCNx9JkL6e+guPad2cMkiIyV\nxuNcNs/7AgMBAAECggEABeKl4xZa8GSpjqda1URu7X4Km9HZRkEtgOgPlyIKVM4I\nAN6U2nXCqa4YB9DeonCnkr7NwsjIEmaqpR+Zn9yfjCIbcUAyZoPNDisKasdi9EVa\nu2/yrxIquStgO/Ixnn1eIQrzLkSRkkLh6rIkw/7FS0YIBhpr+Uwa0RWT1xyy53al\nJbIQ3AZoAe7Wizx0xyQurbTBEnFBR1SsHYWLMqjtDz8FkU1e/EUU/7rlJLrbWhJz\n0kPDMBCFczk4mORosiB0EOR/7ry4VcugRyVeFwkZXtmhTT/q7X4t4p/6Th8g+7C+\nBieUYted5ocs0hO2+8SUD2r1ulsUXEKv8iHlvVpSEQKBgQDN0gvq6L8y4HTUvRma\nRt/uc2n049Hlwb/SMKzaoWLlbWe2TCHGQ3/kzSmMb+RP7qvN6ExKNqP+voc54ZGX\njuUZ1ZByH+eP5MN5/1KZFJXdegVlmVRA4lxSv5hl43IjxoqmLLUr8GDRdWne/Ydx\nRcgcRmWGCxAXBI+NPEKtscFipQKBgQDGu/BlQxWzMgPTGRNKaavAmf35J783OBUs\ncGfM+b8rKdNUxWo4uYakCiStcxjDuGPi5cGCo/dxEbQwvcdww3aaCfxh34xF2c1b\nBR0IoHXDma2PxDRqecBuvc+kK3tf7ZKqgcL5e1TyhnjMfNp8B+2rDhND5MiJMvM/\nvW4qSswGHwKBgQC0rwnRTkPTaSKHQ/6+5itdzKoe1wUD+yPnZN3KDNWh7XqXmZwo\nzkbvWIB6DhxTY4YlfCHFINS1JRPXZ0OF1mcfV9G3rnR9aOmGJvOe+WhbBuzH9WP2\nlgFQj2w9Pf+MkpZTLXpauWp1Vur7XHxTn1v+HnqvwvR8EH/pEBbFHwBTFQKBgFVD\n0TJBBBBsBwQNIB+vEseByluZ2AqC/2Kfn4lsJb8JJOicAqTvxHqg93eLiDaA6Coz\nVUENxF44sEyxP957nmkcm7IKTY6ykc7ZdMl8vsn7J2IlVi/QqOVafrn7BeX0chbB\nsbuEVL/xPebOMpdAd5IKae2ZPQjQWVkhlyCCEuMVAoGAO0eud8lFzNKhCCrQFt0y\n0Amc6vM/8rKsBrIkhicWSKX7OnF+v8lQPob31NYsBmlGwnsfE4y5Z40WSq5/wYxg\ngTBv7IKy/yZhK8qA5OvNCoOYBBsKLwv0d0NNEOZG1MhEmZ9i7dXuDUrCkZQH9L9i\nTm3iLbvabvGDunbiyCFeBow=\n-----END PRIVATE KEY-----\n",
  "client_email": "techstatic-game@techstatic-410506.iam.gserviceaccount.com",
  "client_id": "109439995792341240974",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/techstatic-game%40techstatic-410506.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  }
  ''';

  static const spreadsheetId =  '1k1wDVTErIPNNZzAgP6XQNIRmpDaS2yRXJIZJVSWP6Vk';
  static final _gsheets = GSheets(credentials);
  static Worksheet? _workSheet;
  late String currentHighestScore;

  Future init() async{
    final ss = await _gsheets.spreadsheet(spreadsheetId);
    _workSheet = ss.worksheetByTitle('WorkSheet1');
  }

  static Future insert(String mobileNumber, int score, String name) async{
    if(_workSheet==null )return;
    await _workSheet!.values.appendRow([mobileNumber, score, name]);
  }

  // static Future loadScore() async {
  //   if(_workSheet ==null )return;
  //   final String value = await _workSheet!
  // }

}