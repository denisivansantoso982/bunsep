import 'package:bunsep/database/database_helper.dart';
import 'package:bunsep/models/cake.dart';
import 'package:bunsep/models/category.dart';
import 'package:bunsep/screens/detail_cake_screen.dart';
import 'package:bunsep/templates/colour_template.dart';
import 'package:bunsep/templates/text_style_template.dart';
import 'package:flutter/material.dart';

class CakesScreen extends StatefulWidget {
  const CakesScreen({Key? key}) : super(key: key);

  static const String route = '/cakes_screen';

  @override
  _CakesScreenState createState() => _CakesScreenState();
}

class _CakesScreenState extends State<CakesScreen> {
  late Category category;

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context)!.settings.arguments as Category;
    return Scaffold(
      backgroundColor: ColourTemplate.light,
      appBar: AppBar(
        backgroundColor: ColourTemplate.light,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left_outlined,
            color: ColourTemplate.teal,
            size: 32,
          ),
        ),
        title: Text(
          category.category_name,
          style: TextStyleTemplate.boldTeal(size: 22),
        ),
      ),
      body: FutureBuilder(
          future: DatabaseHelper.instance.getCakes(),
          builder: (BuildContext context, AsyncSnapshot<List<Cake>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'Sedang Memuat...',
                  style: TextStyleTemplate.regularDark(size: 18),
                ),
              );
            }
            List<Cake> cakes = snapshot.data!
                .where(
                    (element) => element.cake_category == category.category_id)
                .toList();
            return cakes.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada data!',
                      style: TextStyleTemplate.regularDark(size: 18),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: cakes.length,
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pushNamed(
                            DetailCakeScreen.route,
                            arguments: cakes[index],
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 16,
                          ),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(.25),
                                  offset: const Offset(2, 4),
                                ),
                              ]),
                          child: Row(
                            children: [
                              Image(
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'lib/assets/images/cake/${cakes[index].cake_image}'),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                cakes[index].cake_name,
                                style: TextStyleTemplate.mediumTeal(size: 16),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
