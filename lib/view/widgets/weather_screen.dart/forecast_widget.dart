import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastWidget extends StatelessWidget {
  final dynamic dateTime;
  final dynamic temperature;
  final dynamic description;
  final dynamic iconUrl;

  const ForecastWidget({
    Key? key,
    this.temperature,
    this.description,
    this.iconUrl,
    this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localData =
        DateTime.fromMillisecondsSinceEpoch(dateTime * 1000, isUtc: true)
            .toLocal();

    final formattedData = DateFormat('dd/MM/yyyy, hh:mm a').format(localData);

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text(formattedData.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconUrl != null
                    ? Image.network(
                        iconUrl,
                      )
                    : Container(),
                Text('${temperature?.round().toString()}°C'),
                Text(description ?? "Carregando ..."),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
