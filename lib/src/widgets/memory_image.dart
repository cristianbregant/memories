import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:memories/src/helper/utils.dart';
import 'package:memories/src/model/memory.dart';



class MemoryImage extends StatelessWidget {
  const MemoryImage(this.imageUrl,
      {Key? key,
      this.loadingBuilder,
      this.errorBuilder,
      this.headers,
      this.cached = false})
      : super(key: key);
  final String imageUrl;
  final Widget? loadingBuilder;
  final Widget? errorBuilder;
  final bool cached;
  final Map<String, String>? headers;

  Future<Uint8List> getImageBytes() async {
    Response response = await get(Uri.parse(imageUrl), headers: headers);

    if (cached && MemoriesUtils.isInitialized) {
      Memory m = Memory(url: imageUrl, byteList: response.bodyBytes);
      await MemoriesUtils.hiveHelper!.add(m);
    }

    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    if (!cached) {
      return _mainImage;
    }

    if (!MemoriesUtils.isInitialized) {
      if (kDebugMode) {
        print("Memories utils not initialized");
      }
      return const Center(
        child: Placeholder(),
      );
    }

    return ValueListenableBuilder(
      valueListenable: MemoriesUtils.hiveHelper!.memoriesBox.listenable(),
      builder: (context, Box<Memory> box, _) {
        // print("SIAMO QIA");
        for (var p in box.values) {
          if (p.url == imageUrl) {
            return Image.memory(p.byteList);
          }
        }
        return _mainImage;
      },
    );
  }

  Widget get _mainImage {
    return FutureBuilder<Uint8List>(
      future: getImageBytes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) return Image.memory(snapshot.data!);

        if (snapshot.hasError) {
          return errorBuilder ?? _defaultErrorWidget;
        }

        return loadingBuilder ?? _defaultLoadingWidget;
      },
    );
  }

  Widget get _defaultLoadingWidget {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            height: 16,
          ),
          Text("Loading...")
        ],
      ),
    );
  }

  Widget get _defaultErrorWidget {
    return const Placeholder();
  }
}
