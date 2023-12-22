class DataMQTT {
  static String broker = 'mqtt.homeautomation.obotrons.com';
  static String clientId = 'MQTT_CONNECT';
  static int port = 1883;
  static String usernameMQTT = 'homeassistant';
  static String passwordMQTT = 'Obt_H0meass1stant';

  static String topic = 'homeassistant/+/+/status'; // Recivetopic
  static List ModeAirPur = [
    "max",
    "smart",
    "windfree",
    "sleep",
  ];
}

class ModelDevice_MQTT {
  String TopicSub;
  Map Status;
  ModelDevice_MQTT({
    required this.TopicSub,
    required this.Status,
  });
}
