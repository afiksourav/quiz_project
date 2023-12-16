void main() {
  var originalData = {
    'answers': [
      {'id': 5001, 'ans': 5001},
      {'id': 5006, 'ans': 5002},
      {'id': 5009, 'ans': 5003}
    ]
  };

  var convertedData = {
    'answers': originalData['answers']!.map((item) {
      return {
        'id': item['id'],
        'ans': item['ans'],
      };
    }).toList()
  };

  print(convertedData);
}
