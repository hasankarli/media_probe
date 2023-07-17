import '../../models/popular_response.dart';

String articleImage(Popular popular) => ((popular.media?.isNotEmpty ?? false) &&
            (popular.media!.first.mediaMetadata?.isNotEmpty ?? false)) ==
        false
    ? ''
    : popular.media!.first.mediaMetadata!.first.url!;
