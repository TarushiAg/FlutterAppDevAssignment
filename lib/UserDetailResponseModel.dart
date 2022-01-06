class UserDetailResponseModel {
  String imageUrl;
  String name;
  int rating;
  int tournamentPlayed;
  int tournamentWon;
  int winPercentage;

  UserDetailResponseModel(
      {this.imageUrl,
      this.name,
      this.rating,
      this.tournamentPlayed,
      this.tournamentWon,
      this.winPercentage});

  UserDetailResponseModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    name = json['name'];
    rating = json['rating'];
    tournamentPlayed = json['tournament_played'];
    tournamentWon = json['tournament_won'];
    winPercentage = json['win_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['tournament_played'] = this.tournamentPlayed;
    data['tournament_won'] = this.tournamentWon;
    data['win_percentage'] = this.winPercentage;
    return data;
  }
}
