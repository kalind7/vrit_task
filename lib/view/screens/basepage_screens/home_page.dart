import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrit_task/view/components/export_components.dart';
import 'package:vrit_task/view/features/export_features.dart';
import 'package:vrit_task/view_model/providers/export_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const String routeName = "/homepage";

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<BasepageProvider>(builder: (context, homeProv, child) {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            homeProv.searchController.clear();
            await homeProv.fetchImageDatas();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: CustomFormField(
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.search,
                    controller: homeProv.searchController,
                    label: 'Search',
                    hintText: 'Search your required images',
                    suffixIcon: InkWell(
                      onTap: () {
                        homeProv.searchController.clear();
                        homeProv.fetchImageDatas();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.black54,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {
                        homeProv.fetchImageDatas(searchQuery: value);
                        log(value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
                child: Text(
                  'Suggestions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (homeProv.hitList.isEmpty) ...[
                const Center(child: Text("No Datas"))
              ] else ...[
                (homeProv.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomGridView(
                        list: homeProv.hitList,
                      )),
              ],
            ],
          ),
        ),
      );
    });
  }
}
