import 'dart:convert';

Map<String, dynamic> parseCleanJson(String raw) {
  // hapus backticks dan label ```json
  String cleaned = raw
      .replaceAll("```json", "")
      .replaceAll("```", "")
      .trim();

  return jsonDecode(cleaned);
}
