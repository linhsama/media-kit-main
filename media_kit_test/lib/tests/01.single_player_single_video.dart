import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../common/globals.dart';
import '../common/widgets.dart';
// import '../common/sources/sources.dart';

class SinglePlayerSingleVideoScreen extends StatefulWidget {
  const SinglePlayerSingleVideoScreen({Key? key}) : super(key: key);

  @override
  State<SinglePlayerSingleVideoScreen> createState() =>
      _SinglePlayerSingleVideoScreenState();
}

class _SinglePlayerSingleVideoScreenState
    extends State<SinglePlayerSingleVideoScreen> {
  late final Player player = Player();
  late final VideoController controller = VideoController(
    player,
    configuration: configuration.value,
  );

  final sources = [
    {
      'name': 'chanel 1',
      'url':
          'rtsp://admin:kimdong789@mnkimdong.ddns.net:554/cam/realmonitor?channel=1&subtype=0',
    },
    {
      'name': 'chanel 2',
      'url':
          'rtsp://admin:kimdong789@mnkimdong.ddns.net:554/cam/realmonitor?channel=2&subtype=0',
    },
    {
      'name': 'chanel 3',
      'url':
          'rtsp://admin:kimdong789@mnkimdong.ddns.net:554/cam/realmonitor?channel=3&subtype=0',
    },
    {
      'name': 'chanel 4',
      'url':
          'rtsp://admin:kimdong789@mnkimdong.ddns.net:554/cam/realmonitor?channel=4&subtype=0',
    },
    {
      'name': 'chanel 5',
      'url':
          'rtsp://admin:kimdong789@mnkimdong.ddns.net:554/cam/realmonitor?channel=5&subtype=0',
    },
  ];

  @override
  void initState() {
    super.initState();
    player.open(Media(sources[0]['url'].toString()));
    player.stream.error.listen((error) => debugPrint(error));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  List<Widget> get items => [
        for (int i = 0; i < sources.length; i++)
          ListTile(
            title: Text(
              sources[i]['name'].toString(),
              style: const TextStyle(
                fontSize: 14.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              player.open(Media(sources[i]['url'].toString()));
            },
          ),
      ];

  @override
  Widget build(BuildContext context) {
    final horizontal =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('package:media_kit'),
      ),
      // floatingActionButton: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     FloatingActionButton(
      //       heroTag: 'file',
      //       tooltip: 'Open [File]',
      //       onPressed: () => showFilePicker(context, player),
      //       child: const Icon(Icons.file_open),
      //     ),
      //     const SizedBox(width: 16.0),
      //     FloatingActionButton(
      //       heroTag: 'uri',
      //       tooltip: 'Open [Uri]',
      //       onPressed: () => showURIPicker(context, player),
      //       child: const Icon(Icons.link),
      //     ),
      //   ],
      // ),
      body: SizedBox.expand(
        child: horizontal
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 8.0,
                              clipBehavior: Clip.antiAlias,
                              margin: const EdgeInsets.all(32.0),
                              child: Video(
                                controller: controller,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32.0),
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1.0, thickness: 1.0),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: items,
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  Video(
                    controller: controller,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 9.0 / 16.0,
                  ),
                  ...items,
                ],
              ),
      ),
    );
  }
}
