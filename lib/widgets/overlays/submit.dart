import 'package:gsheets/gsheets.dart';

class SubmitData{
    static const String credentials = r'''
  {
  "type": "service_account",
  "project_id": "techstatic-sheets-test",
  "private_key_id": "1c8932d14185499ae5c3a1814eec56962217c75d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDD9tCz4pIMp1ig\nC5QuVGCmx37JJCtGUwLtXTia7oFzfYetfry2LUNfPIb0oSrN8DLtOIqxj+4tE4QK\nssLNIPUDJZMzGqTluDrwOZ8PMplud/uIHhw7zyhsyY2BkeaBQPIhj8E/8yvx0BJt\nk++WDKF+s33NyRKU0q8SDIWLGf1FwHTftRi2rAsCcJlC5IIpUNRRgqBtaBIJaNhU\nMhKRUvyGsIz01IvE5bXwtOrrhGMK0uSBnnywmpuBiXnUxfcebdVEKYA/qAL0rFIy\nY0EDEXIyGpwOMNKrCwjmPSDcJKOMS5flgo4Z1HrRVzk7MN+pqvhVXkvhiipHKwMs\nH2ThfnotAgMBAAECggEABoDXIb/L5Cwcj+klIIQlK1EVDHn3uVnRZSJcxHV+/x/E\nGYD1JHWW617v7/KLoAclOtlPbv+YDPpoEs57vQDSPhRokL+vsmjyrxy2bN5wwulW\nmV3ocXVZQdekK3qK+VtNUx75GpUdw6S0VoXG48ZPs2D5Ceku8ENCqJkY8x9obUCx\naszYL8YrfV4+kH9rVteADOuNOhDLRiDTsf/7cKUOPf9M/e3bnIaRq7nPus5b9LwA\nKbR1vEwUFMuV73pBDaeqJ14n4/ChX/RUaWyqSvoNj7d5orw8X0eS0nd0kNVL21xM\nFpWKeIO6svPrriww+BqF9Cs3aOGWUeDLUq0sDMwc2QKBgQD9ZhITaV4zr7cM3zo3\nerkjE+R7eD3wvIjg8kNWOHiHAkDRgXEglST8UgAB8bEflDI1G9SARRN0j5K59wlU\n8aStkmNoZnuA/k3ST5jRsvxFdENLWNo1hAgM+EtzVUwuRzdkmYD75EMJd3dV2bR0\nQDY3Rare6ojXcZxGRFG4Z8Fv1QKBgQDF+c6c0wFSLIf7ja2gVMhMP7Hr1kYxPSs9\ngacoe+kY5/sgXbgBS2l7aEASo8CYkDlVAUEA1UnrllwCDu9j8uNd+PgJ45GZccnz\nffJ6a1cETCwetS1JWpzDrlmvxLdSOWDkQv8LNsVL4S7IzDsRAjqmW9ihidLf9SNn\n6mdAwkPk+QKBgGI+bamrA4Pkj4LlFUwnP5pS/xXDw7gPUL5uDx9hm5E0lW7k0biB\nOqq9HBWk4DhPG7wtgxEMNwPNGmURW0PcwC0vgW0btqyHbCKrC6PZ0icXcXPICioP\ne5OTvKUFoBidMePGBBUlJbyI3fKiCm2764k4cIwmwFFPUfiISmrFh2DVAoGAESlL\naLq9xZLIotywLVLMHhfzY18qrIAB7I39oHvFQ/xv/2lAVxRja2gpDbSWMGNoJN87\n9EeI5dwd06vZwo8+eFnpnmnUqDl96RaE22nMnDnCJVNNPquVJT1K1vq1bXI93OuV\n0jIIPkCh3pQdlqbb0KnriG07E2Dbldly4+EzI3kCgYEA6419A9pBGGKLFGRULqYG\n4bPdNcdsTwukel66R71Q/uaucbS3psVSDtd1MuHAcpNB7CnBGDnhkUjxQa9QXTv1\nJtt9wzTcCw3OIAI2qHIyDVbQL9Ecxd5hYk61+r7Bd9McHWgau9jEcF7yE2N5k4EJ\nfOiR7V6yoDcNtVhOQAQGd7k=\n-----END PRIVATE KEY-----\n",
  "client_email": "techstatic-test@techstatic-sheets-test.iam.gserviceaccount.com",
  "client_id": "107320639282399450955",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/techstatic-test%40techstatic-sheets-test.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"

''';

  Future<bool> insertData(int mobile, int score, Worksheet workSheet) {
    return workSheet.values
        .appendRow([mobile, score, DateTime.now().toString()]);
  }

  final sheetsId = '1V15hUng0U8FKwUxfBT2Bav0C8E127JGiWMaeXYpzKwc';
  final worksheetId = 2146561186;
  late final gsheets = GSheets(credentials);
  late Worksheet worksheet =gsheets.spreadsheet(sheetsId).worksheetByTitle('user');


}