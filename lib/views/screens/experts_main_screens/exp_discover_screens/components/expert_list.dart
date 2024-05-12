import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/expert_profile.dart';
import 'package:ifit/views/widgets/container/square.dart';
import 'package:ifit/models/expert.dart';

class ExpertExpertListWidget extends StatelessWidget {
  const ExpertExpertListWidget({
    required this.discoverExperts,
    super.key,
  });

  final List<ExpertModel> discoverExperts;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:15),
          child: Text("Experts",
            style: Styles.title
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as per your design
          ),
          itemCount: discoverExperts.length,
          itemBuilder: (context, index) {
            ExpertModel exObj = discoverExperts[index];

            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ExpertExpertProfile(
                    expertId: exObj.uid,
                  )),
                );
              },
              child: SquareContainer(
                image: exObj.professionId,
                title: exObj.name,
                bottomText: "${exObj.profession} | ${exObj.rating} stars",
              ),
            );
          },
        )
      ],
    );
  }
}
