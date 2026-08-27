class AmbientSettings {
  final bool showClock;
  final bool showDate;
  final bool showWeather;
  final bool showLocation;
  final bool showMyFarm;
  final int timeout;

  const AmbientSettings({
    this.showClock = true,
    this.showDate = true,
    this.showWeather = true,
    this.showLocation = true,
    this.showMyFarm = true,
    this.timeout = 30,
  });

  AmbientSettings copyWith({
    bool? showClock,
    bool? showDate,
    bool? showWeather,
    bool? showLocation,
    bool? showMyFarm,
    int? timeout,
  }) {
    return AmbientSettings(
      showClock: showClock ?? this.showClock,
      showDate: showDate ?? this.showDate,
      showWeather: showWeather ?? this.showWeather,
      showLocation: showLocation ?? this.showLocation,
      showMyFarm: showMyFarm ?? this.showMyFarm,
      timeout: timeout ?? this.timeout,
    );
  }
}