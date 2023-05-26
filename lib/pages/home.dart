import 'package:flutter/material.dart';
import 'fetching.dart';
import 'rough.dart' as rough;
import 'thumbnail.dart' as thumbnail;

class ThumbnailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: fetchHome(0),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data!;
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                rough.TikTokPage(value: [0, index])));
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[2][index].toString()),
                  ),
                  title: Text('Uploader Name ' + data[1][index].toString()),
                  subtitle: Image.network(data[0][index].toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
