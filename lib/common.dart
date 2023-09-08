class Global {
  static int tableId = 1;
  static get team => tableId < 5 ? 0 : 1;
  static String getAssetImageUrl(String filename) {
    return team == 0
        ? "assets/images/team_wolf/$filename"
        : "assets/images/team_shark/$filename";
  }
}
