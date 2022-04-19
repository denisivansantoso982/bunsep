import 'package:bunsep/database/database_helper.dart';
import 'package:bunsep/models/category.dart';
import 'package:bunsep/screens/cakes_screen.dart';
import 'package:bunsep/templates/colour_template.dart';
import 'package:bunsep/templates/text_style_template.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String route = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> categoryCard(BuildContext context, List<Category> categories) {
    return List.generate(
      categories.length,
      (index) => GestureDetector(
        onTap: () async {
          Navigator.of(context)
              .pushNamed(CakesScreen.route, arguments: categories[index]);
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'lib/assets/images/category/${categories[index].category_image}'),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  offset: const Offset(2, 4),
                  blurRadius: 4,
                )
              ]),
          child: Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: Colors.white,
            height: 36,
            child: Text(
              categories[index].category_name,
              style: TextStyleTemplate.boldTeal(size: 16),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourTemplate.light,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Halo, Selamat Datang',
                style: TextStyleTemplate.mediumDark(size: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    'Di ',
                    style: TextStyleTemplate.mediumDark(size: 24),
                  ),
                  Text(
                    'BUNSEP',
                    style: TextStyleTemplate.boldTeal(size: 24),
                  ),
                  Text(
                    '!!!',
                    style: TextStyleTemplate.mediumDark(size: 24),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            FutureBuilder(
              future: DatabaseHelper.instance.getCategories(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Category>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      'Sedang Memuat...',
                      style: TextStyleTemplate.regularDark(size: 18),
                    ),
                  );
                }
                return snapshot.data!.isEmpty
                    ? Center(
                        child: Text(
                          'Tidak ada data!',
                          style: TextStyleTemplate.regularDark(size: 18),
                        ),
                      )
                    : GridView.count(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2.4 / 3,
                        scrollDirection: Axis.vertical,
                        controller: ScrollController(),
                        children: categoryCard(context, snapshot.data!),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
