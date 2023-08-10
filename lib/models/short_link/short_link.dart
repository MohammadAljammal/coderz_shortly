class ShortLink {
  int? id;
  String? code;
  String? shortLink;
  String? fullShortLink;
  String? shortLink2;
  String? fullShortLink2;
  String? shortLink3;
  String? fullShortLink3;
  String? shareLink;
  String? fullShareLink;
  String? originalLink;

  ShortLink(
      {
        this.code,
        this.shortLink,
        this.fullShortLink,
        this.shortLink2,
        this.fullShortLink2,
        this.shortLink3,
        this.fullShortLink3,
        this.shareLink,
        this.fullShareLink,
        this.originalLink});

  ShortLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code']??'';
    shortLink = json['short_link']??'';
    fullShortLink = json['full_short_link']??'';
    shortLink2 = json['short_link2']??'';
    fullShortLink2 = json['full_short_link2']??'';
    shortLink3 = json['short_link3']??'';
    fullShortLink3 = json['full_short_link3']??'';
    shareLink = json['share_link']??'';
    fullShareLink = json['full_share_link']??'';
    originalLink = json['original_link']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['short_link'] = shortLink;
    data['full_short_link'] = fullShortLink;
    data['short_link2'] = shortLink2;
    data['full_short_link2'] = fullShortLink2;
    data['short_link3'] = shortLink3;
    data['full_short_link3'] = fullShortLink3;
    data['share_link'] = shareLink;
    data['full_share_link'] = fullShareLink;
    data['original_link'] = originalLink;
    return data;
  }
}
