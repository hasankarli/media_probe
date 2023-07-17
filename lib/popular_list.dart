import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_probe/core/extensions/string_extension.dart';
import 'package:media_probe/router/routes.dart';

import 'cubit/popular_list_cubit.dart';

class PopularList extends StatelessWidget {
  const PopularList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularListCubit, PopularListState>(
      builder: (context, state) {
        switch (state.status) {
          case PopularListStatus.initial:
          case PopularListStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case PopularListStatus.loaded:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemCount: state.popularList.length,
              itemBuilder: (context, index) {
                final popular = state.popularList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.articleDetail, arguments: popular);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: articleImage(popular).isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(articleImage(popular)),
                              )
                            : Container(),
                      ),
                      title: Text(
                        popular.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15),
                      ),
                      subtitle: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text('${popular.abstract}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 13)),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text('${popular.byline}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 13)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  Text('${popular.publishedDate}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                  ),
                );
              },
            );
          case PopularListStatus.error:
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    context.read<PopularListCubit>().fetchPopularList();
                  },
                  child: const Text('Retry')),
            );
        }
      },
    );
  }
}
