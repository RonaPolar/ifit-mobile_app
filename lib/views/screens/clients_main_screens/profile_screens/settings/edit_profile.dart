import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    required this.clientModel,
    super.key,
  });

  final ClientModel clientModel;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  void initState() {
    super.initState();
    getData(context);
  }

  void getData(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    final ClientModel client = widget.clientModel;

    setState(() {
      Auth.name.text = client.name;
      Auth.phone.text = client.phoneNumber;
      Auth.height.text = client.height;
      Auth.weight.text = client.weight;
      auth.gender = client.gender;
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              FluentSystemIcons.ic_fluent_chevron_left_filled,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: Styles.headline20,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Profile Details", style: Styles.title),
                        const Gap(15),
                        TextFieldContainer(
                          controller: Auth.name,
                          hintText: "Name",
                          icon: FluentSystemIcons.ic_fluent_edit_regular,
                        ),
                        const Gap(15),
                        TextFieldContainer(
                          controller: Auth.phone,
                          hintText: "Number",
                          icon: FluentSystemIcons.ic_fluent_edit_regular,
                        ),
                        const Gap(15),
                        RegisterDropDown(
                          hintText: 'Gender',
                          icon: FluentSystemIcons.ic_fluent_people_regular,
                          items: auth.genderList.map((data) {
                            return  DropdownMenuItem<String>(
                              value: data,
                              child: Text(data),
                            );
                          }).toList(),
                          onChanged: auth.updateGender,
                          selectedValue: auth.gender,
                        ),
                        const Gap(15),
                        TextFieldContainer(
                          controller: Auth.height,
                          hintText: "Height",
                          icon: FluentSystemIcons.ic_fluent_edit_regular,
                        ),
                        const Gap(15),
                        TextFieldContainer(
                          controller: Auth.weight,
                          hintText: "Weight",
                          icon: FluentSystemIcons.ic_fluent_edit_regular,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: MainButton(
                title: "Update Changes",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                          onYesPressed: () async {
                            await auth.editClientProfile(widget.clientModel.uid).then((value) {
                              Navigator.of(context)..pop()..pop();
                            });
                          },
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
