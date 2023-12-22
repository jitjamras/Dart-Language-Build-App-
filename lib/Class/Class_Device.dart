class ModelDevice {
  String name;
  bool active;
  String mode;
  String Pathsubscribe;
  String Pathpublish;
  ModelDevice({
    required this.name,
    this.active = false,
    this.mode = '',
    this.Pathsubscribe = '',
    this.Pathpublish = '',
  });
}

List<ModelDevice> ItemDevice = [
  ModelDevice(
    name: 'air_pur',
    Pathsubscribe: 'homeassistant/master_bedroom/air_pur/status',
    Pathpublish: 'homeassistant/master_bedroom/air_pur',
  ),
  ModelDevice(
      name: 'ls_1g_1',
      Pathsubscribe: 'homeassistant/master_bedroom/ls_1g_1/status',
      Pathpublish: 'homeassistant/master_bedroom/ls_1g_1'),
  ModelDevice(
      name: 'ls_2g_1',
      Pathsubscribe: 'homeassistant/master_bedroom/ls_2g_1/status',
      Pathpublish: 'homeassistant/master_bedroom/ls_2g_1'),
  ModelDevice(
      name: 'ls_2g_2',
      Pathsubscribe: 'homeassistant/master_bedroom/ls_2g_2/status',
      Pathpublish: 'homeassistant/master_bedroom/ls_2g_2'),
  ModelDevice(
      name: 'ct_2g_1',
      Pathsubscribe: 'homeassistant/multi_purpose/ct_2g_1/status',
      Pathpublish: 'homeassistant/multi_purpose/ct_2g_1'),
  ModelDevice(
      name: 'lsd_1g_1',
      Pathsubscribe: 'homeassistant/living_room/lsd_1g_1/status',
      Pathpublish: 'homeassistant/living_room/lsd_1g_1'),
];
