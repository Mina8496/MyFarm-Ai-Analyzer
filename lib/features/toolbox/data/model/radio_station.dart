class RadioStation {
  final String name;
  final String logoUrl;
  final String streamUrl;

  RadioStation({
    required this.name,
    required this.logoUrl,
    required this.streamUrl,
  });
}

final List<RadioStation> stations = [
  RadioStation(
    name: "راديو الرجاء",
    logoUrl: "assets/radiopage/logo-radio.png",
    streamUrl: "https://i7.streams.ovh/sc/hoperad2/stream",
  ),

  RadioStation(
    name: "إذاعة القرآن الكريم من القاهرة",
    logoUrl: "assets/radiopage/quran.jpg",
    streamUrl: "https://stream.radiojar.com/8s5u5tpdtwzuv",
  ),

  RadioStation(
    name: "نجوم FM",
    logoUrl: "assets/radiopage/nogoom.png",
    streamUrl: "https://stream.zeno.fm/qb1zvsykm98uv",
  ),

  RadioStation(
    name: "راديو 9090",
    logoUrl: "assets/radiopage/راديو9090.jpg",
    streamUrl: "https://9090streaming.mobtada.com/9090FMEGYPT",
  ),
];
