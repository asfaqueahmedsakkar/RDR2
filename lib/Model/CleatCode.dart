class CheatCode {
  String title, effect, code, requirement;

  CheatCode.fromJson(Map<String, dynamic> json) {
    title = json["Title"];
    effect = json["Effect"];
    code = json["Code"];
    requirement = json["Requirement"];
  }
}
