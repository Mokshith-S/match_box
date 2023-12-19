import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  String processTime(String time) {
    List<String> partedTime = time.split(':');
    String hr = partedTime[0].length == 1 ? '0${partedTime[0]}' : partedTime[0];
    String sec = partedTime[2].split('.')[0];
    return '$hr : ${partedTime[1]} : $sec';
  }

  Future<List<String?>> dbProcessing() async {
    final pref = await SharedPreferences.getInstance();
    String? easy;
    String? med;
    String? hard;

    easy = pref.getString('Easy') == null
        ? null
        : processTime(pref.getString('Easy')!);

    med = pref.getString('Medium') == null
        ? null
        : processTime(pref.getString('Medium')!);

    hard = pref.getString('Hard') == null
        ? null
        : processTime(pref.getString('Hard')!);

    return [easy, med, hard];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Board'),
      ),
      body: FutureBuilder(
        future: dbProcessing(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Records',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                if (snapshot.data!.elementAt(0) != null)
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(192, 164, 220, 248)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Easy',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          snapshot.data!.elementAt(0)!,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ],
                    ),
                  ),
                if (snapshot.data!.elementAt(1) != null)
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(192, 164, 220, 248)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Medium',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          snapshot.data!.elementAt(1)!,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ],
                    ),
                  ),
                if (snapshot.data!.elementAt(2) != null)
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(192, 164, 220, 248)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Hard',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          snapshot.data!.elementAt(2)!,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ],
                    ),
                  )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
