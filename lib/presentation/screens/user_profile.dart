import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/presentation/providers/user_profile.dart';
import 'package:habix/presentation/screens/widgets/custom_button.dart';
import 'package:habix/presentation/screens/widgets/name_text_box.dart';
import 'package:habix/presentation/screens/widgets/selectable_box.dart';
import 'package:habix/utilities/extensions.dart';
import 'package:habix/utilities/icon_paths.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
 
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  late Map<String, dynamic> _params;
   int _weight = 0;

  @override
  Widget build(BuildContext context) {
    _params = ref.watch(userProfileScreenNotifier);
    return Scaffold(
      bottomNavigationBar: Wrap(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: CustomButton(onButtonTapped: (){}, buttonText: 'Set Profile', isLoading: false)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                child: Image.asset(profileIcon,
                ),
              ),
              SizedBox(height: 10,),
              Text('Tell us about yourself',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 10,),
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
                  SizedBox(
                    width: 
                    130,
                    child: Text('Date of Birth: ')),
                  Expanded(
                    child: Container( 
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ScrollDatePicker(
                              selectedDate: DateTime.now(),
                              locale: Locale('en'),
                              onDateTimeChanged: (DateTime value) {},
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 
                    130,child: Text('Gender: ')),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: SelectableBox(
                        onOptionSelected: () {
                        ref.read(userProfileScreenNotifier.notifier).changeGender(Gender.MALE);
                        },
                        option: Text('Male'),
                        selectedColor: Colors.blue,
                        isSelected: _params['gender'] == Gender.MALE,
                      ),
                    ),
                  ),
                  Expanded( 
                    child: SelectableBox(
                      onOptionSelected: () 
                      {
                        ref.read(userProfileScreenNotifier.notifier).changeGender(Gender.FEMALE);
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
                  SizedBox(
                      width: 130,
                      child: Text('Weight: '),
                      ),
                    Expanded(
                      child: TextField(
                      controller: _weightController,
                      onChanged: (value)
                      {
                        _weight = int.parse(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      
                      ),
                      keyboardType: TextInputType.number,
                      
                    )),
                    SizedBox(
                      width: 150,
                      child: RadioGroup<WeightUnit>(
                        groupValue: _params['unit_weight'],
                        onChanged: (wu)
                      {
                        ref.read(userProfileScreenNotifier.notifier).changeWeightUnit(
                          wu!
                        );

                        if(wu == WeightUnit.KG){
                          _weightController.text = _weight.toKg.toString();
                        }
                        else{
                          _weightController.text = _weight.toLbs.toString();
                        }
                      }, child: 
                      Row(
                        children: [
                          Radio<WeightUnit>(
                        value: WeightUnit.KG,),
                        SizedBox(
                          width: 50,
                          child: Text('kg')),
                          Radio<WeightUnit>(
                        value: WeightUnit.LBS,),
                        Text('lbs'),
                        ],
                      )),
                    ),
                    
          ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                      width: 130,
                      child: Text('Height: '),
                      ),
                    Expanded(
                      child: TextField(
                      
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      
                      ),
                      keyboardType: TextInputType.number,
                      
                    )),
                    SizedBox(
                      width: 150,
                      child: RadioGroup<HeightUnit>(
                        groupValue: _params['unit_height'],
                        onChanged: (hu)
                      {
                        ref.read(userProfileScreenNotifier.notifier).changeHeightUnit(
                          hu!
                        );
                      }, child: 
                      Row(
                        children: [
                          Radio<HeightUnit>(
                        value: HeightUnit.INCH,),
                        SizedBox(
                          
                          width: 50, child: Text('inch')),
                          Radio<HeightUnit>(
                        value: HeightUnit.CM,),
                        Text('cm'),
                        ],
                      )),
                    ),
          ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
