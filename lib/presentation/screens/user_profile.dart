import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/presentation/UIModels/userProfileUI.dart';
import 'package:habix/presentation/providers/user_profile.dart';
import 'package:habix/presentation/screens/widgets/custom_button.dart';
import 'package:habix/presentation/screens/widgets/name_text_box.dart';
import 'package:habix/presentation/screens/widgets/selectable_box.dart';
import 'package:habix/utilities/enums.dart';
import 'package:habix/utilities/extensions.dart';
import 'package:habix/utilities/icon_paths.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  late Map<String, dynamic> _params;
  int _weightInKgs = 0; //in kgs (by default)
  int _weightInLbs = 0;
  int _heightInInch = 0; //in inches (by default)
  int _heightInCM = 0;

  @override
  Widget build(BuildContext context) {
    _params = ref.watch(userProfileScreenNotifier);
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent.withValues(alpha: 0.1),
      bottomNavigationBar: Wrap(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: CustomButton(
              onButtonTapped: () async{
                if (_formKey.currentState!.validate()) 
                {
                  UserProfileUIModel userUI = UserProfileUIModel(
                    _firstNameController.text.trim(),
                    _lastNameController.text.trim(),
                    _params['dob'],
                    _params['gender'],
                    _weightInKgs,
                    _heightInCM,
                  );

                  bool success = await ref.read(userProfileScreenNotifier.notifier).setProfile(userUI);
                  if(success)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile set successfully!')),
                    );
                  }
                  else
                  {
                    Future.delayed(Duration(milliseconds: 300));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(_params['error_message'])),
                    );
                  }
                
                }
              },
              buttonText: 'Set Profile',
              isLoading: _params['loading'],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatar(radius: 80, child: Image.asset(profileIcon)),
                SizedBox(height: 10),
                Text(
                  'Tell us about yourself',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
                NameTextField(
                  controller: _firstNameController,
                  labelText: 'First Name',
                ),
                SizedBox(height: 10),
                NameTextField(
                  controller: _lastNameController,
                  labelText: 'Last Name',
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 130, child: Text('Date of Birth: ')),
                    Expanded(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withValues(alpha: 0)
                        ),
                        child: ScrollDatePicker(
                          options: DatePickerOptions(
                            diameterRatio: 6,
                            isLoop: false,
                            backgroundColor: Colors.white.withValues(alpha: 0)
                          ),
                          selectedDate: _params['dob']!,
                          locale: Locale('en'),
                          onDateTimeChanged: (DateTime value) 
                          {
                            ref.read(userProfileScreenNotifier.notifier).changeDOB(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 130, child: Text('Gender: ')),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: SelectableBox(
                          onOptionSelected: () {
                            ref
                                .read(userProfileScreenNotifier.notifier)
                                .changeGender(Gender.MALE);
                          },
                          option: Text('Male'),
                          selectedColor: Colors.blue,
                          isSelected: _params['gender'] == Gender.MALE,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SelectableBox(
                        onOptionSelected: () {
                          ref
                              .read(userProfileScreenNotifier.notifier)
                              .changeGender(Gender.FEMALE);
                        },
                        option: Text('Female'),
                        selectedColor: Colors.pinkAccent,
                        isSelected: _params['gender'] == Gender.FEMALE,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 130, child: Text('Weight: ')),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Field cannot be empty';
                          }
                          else if (value == '0') {
                            return 'Invalid entry';
                          }
                          return null;
                        },
                        controller: _weightController,
                        onChanged: (value) {
                          try{
                          if(_params['unit_weight'] == WeightUnit.KG){
                          _weightInKgs = int.parse(value);
                          _weightInLbs = _weightInKgs.toLbs;}
                          else{
                          _weightInLbs = int.parse(value);
                          _weightInKgs = _weightInLbs.toKg;}
                          }catch(e){}
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioGroup<WeightUnit>(
                        groupValue: _params['unit_weight'],
                        onChanged: (wu) {
                          ref
                              .read(userProfileScreenNotifier.notifier)
                              .changeWeightUnit(wu!);

                          if (wu == WeightUnit.KG) {
                            _weightController.text = _weightInKgs
                                .toString(); //.toKg.toString();
                          } else {
                            _weightController.text = _weightInLbs.toString();
                          }
                        },
                        child: Row(
                          children: [
                            Radio<WeightUnit>(value: WeightUnit.KG),
                            SizedBox(width: 50, child: Text('kg')),
                            Radio<WeightUnit>(value: WeightUnit.LBS),
                            Text('lbs'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 130, child: Text('Height: ')),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Field cannot be empty';
                          }
                          else if (value == '0') {
                            return 'Invalid entry';
                          }
                          return null;
                        },
                        controller: _heightController,
                        onChanged: (value) {
                          try{
                          if(_params['unit_height'] == HeightUnit.INCH){
                          _heightInInch = int.parse(value);
                          _heightInCM = _heightInInch.toCm;
                          }
                          else{
                          _heightInCM = int.parse(value);
                          _heightInInch = _heightInCM.toInch;
                          }
                          }catch(e){}
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioGroup<HeightUnit>(
                        groupValue: _params['unit_height'],
                        onChanged: (hu) {
                          ref
                              .read(userProfileScreenNotifier.notifier)
                              .changeHeightUnit(hu!);

                          if (hu == HeightUnit.INCH) {
                            _heightController.text = _heightInInch
                                .toString(); //.toKg.toString();
                          } else {
                            _heightController.text = _heightInCM.toString();
                          }
                        },
                        child: Row(
                          children: [
                            Radio<HeightUnit>(value: HeightUnit.INCH),
                            SizedBox(width: 50, child: Text('inch')),
                            Radio<HeightUnit>(value: HeightUnit.CM),
                            Text('cm'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
