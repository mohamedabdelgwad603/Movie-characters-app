class Episode {
  String? episodeName;
  Episode.fromJson(Map<String, dynamic> json) {
    episodeName = json['name'];
  }
}
