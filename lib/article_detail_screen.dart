import 'package:flutter/material.dart';
import 'package:media_probe/core/extensions/string_extension.dart';
import 'package:media_probe/models/popular_response.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key, required this.popular});
  final Popular popular;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          articleImage(widget.popular).isNotEmpty
              ? SizedBox(
                  height: 250,
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.network(
                    articleImage(
                      widget.popular,
                    ),
                    fit: BoxFit.cover,
                  ))
              : Container(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.popular.title ?? '',
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.popular.abstract ?? '',
                  style: TextStyle(
                      fontSize: 15, color: Colors.grey[600], height: 1.4),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.popular.byline ?? '',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined, size: 15),
                          Text(widget.popular.publishedDate?.toString() ?? ''),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
