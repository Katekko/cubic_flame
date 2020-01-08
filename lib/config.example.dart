// HINT: Copy this file and create another one named config.dart, so you can use in the rest lib!

class ConfigEnvironments {
  // HINT: Change the current environments to change your current endPoint
  final String _currentEnvironments = 'prod';
  List<Map<String, String>> _availableEnvironments = [
    {
      'env': 'local',
      'url': 'http://192.168.0.2:5000/api/',
      'secret': ''
    },
    {
      'env': 'dev',
      'url': '',
      'secret': ''
    },
    {
      'env': 'preprod',
      'url': '',
      'secret': '',
    },
    {
      'env': 'prod',
      'url': '',
      'secret': ''
    },
  ];

  Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == _currentEnvironments,
    );
  }
}
