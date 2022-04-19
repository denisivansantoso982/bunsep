import 'package:bunsep/database/database_helper.dart';
import 'package:bunsep/models/cake.dart';
import 'package:bunsep/models/receipt.dart';
import 'package:bunsep/templates/colour_template.dart';
import 'package:bunsep/templates/text_style_template.dart';
import 'package:flutter/material.dart';

class DetailCakeScreen extends StatefulWidget {
  const DetailCakeScreen({Key? key}) : super(key: key);

  static const String route = '/detail_cake_screen';

  @override
  _DetailCakeScreenState createState() => _DetailCakeScreenState();
}

class _DetailCakeScreenState extends State<DetailCakeScreen> {
  late Cake cake;

  @override
  Widget build(BuildContext context) {
    cake = ModalRoute.of(context)!.settings.arguments as Cake;
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
          cake.cake_name,
          style: TextStyleTemplate.boldTeal(size: 22),
        ),
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance.getReceiptByID(cake),
        builder: (BuildContext context, AsyncSnapshot<List<Receipt>> snapshot) {
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
              : SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 16,
                  right: 16,
                  bottom: 12,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: const Offset(2, 4),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bahan',
                            style: TextStyleTemplate.boldTeal(size: 20),
                          ),
                          const SizedBox(height: 12,),
                          Text(
                            snapshot.data!.first.receipt_ingredients,
                            style: TextStyleTemplate.regularDark(size: 16),
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: const Offset(2, 4),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cara',
                            style: TextStyleTemplate.boldTeal(size: 20),
                          ),
                          const SizedBox(height: 12,),
                          Text(
                            snapshot.data!.first.receipt_implementation,
                            style: TextStyleTemplate.regularDark(size: 16),
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
