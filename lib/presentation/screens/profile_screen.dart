import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/presentation/UIModels/userProfileUI.dart';
import 'package:habix/presentation/providers/profile_screen.dart';
import 'package:habix/presentation/providers/user_profile.dart';
import 'package:habix/presentation/screens/user_profile.dart';
import 'package:habix/presentation/screens/widgets/custom_button.dart';
import 'package:habix/presentation/screens/widgets/info_box.dart';
import 'package:habix/utilities/enums.dart';
import 'package:habix/utilities/extensions.dart';
import 'package:habix/utilities/icon_paths.dart';
import 'package:habix/utilities/navigator.dart';
import 'package:habix/utilities/shimmer_animation.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late Map<String, dynamic> _params;
  UserProfileUIModel? _userProfileUI;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _params = ref.watch(profileScreenNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileScreen'),
        actions: [
          
         _params['profile'] == null ?Container(): TextButton(onPressed: () async
        {
          
          
    ref.read(userProfileScreenNotifier.notifier).changeGender(_params['profile']?.gender ?? Gender.MALE);
    ref.read(userProfileScreenNotifier.notifier).changeDOB(_params['profile']?.dob ?? DateTime.now());

    await Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfileScreen(
showSkipButton: false, userProfileUIModel: _params['profile'] as UserProfileUIModel,
    )));
    ref.invalidate(profileScreenNotifier);
          setState(() {
            
          });
        }, child: Text('Edit'))],
      ),
      body: _params['loading']
          ? ShimmerAnimation.listPlaceholder()
          : LayoutBuilder(
              builder: (context, constraints) {
                _userProfileUI = _params['profile'] as UserProfileUIModel?;

                return _params['profile'] == null ? Column(
                spacing: 20,
                  children: [
                    
                CircleAvatar(radius: 80, child: Image.asset(profileIcon)),
                Text("No Profile Found", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    CustomButton(
                      
                      buttonWidth: 150,
                      onButtonTapped: () async
                      { 
                        await Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfileScreen(showSkipButton: false,)));
                        
                        ref.invalidate(profileScreenNotifier);
          setState(() {
            
          });
                        }, buttonText: 'Set Profile', isLoading: false), 
                  ],
                ) : _portrait(); // _ProfilescreenWidth>maxProfileScreenSizeInPortraitMode?_landscape():_portrait();
              },
            ),
    );
  }

  Widget _landscape() {
    return _portrait();
  }

  Widget _portrait() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
              spacing: 10,
          children: [
            Row(
              spacing: 10,
              children: [
                Expanded(child: InfoBox(text: '${_userProfileUI!.firstName} ${_userProfileUI!.lastName}'))
              ],
            ),
            Row(
              spacing: 10,
              children: [
                  Expanded(flex: 1, child: InfoBox(gradient: [
                            Colors.lightGreen,
                            const Color.fromARGB(255, 194, 228, 0),
                          ], text: 'Age: ${_userProfileUI!.age.toString()}')),
                  Expanded(
                    flex: 2,
                    child: InfoBox(gradient: [
                      Colors.red,
                            const Color.fromARGB(255, 245, 153, 153),
                          
                  ], text: 'Date Of Birth: ${_userProfileUI!.dob.day} ${_userProfileUI!.dob.month.monthInAlphabets} ${_userProfileUI!.dob.year}'))
              
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 2,
                  child: InfoBox(gradient: [Colors.deepPurple, Colors.purpleAccent], text: 'Weight: ${_userProfileUI!.weight} kg') 
                ),
                
                Expanded(
                  flex: 1,
                  child: InfoBox(text: 'Height: ${_userProfileUI!.height} cm', gradient: [Colors.teal, Colors.tealAccent],) 
                ),
                Expanded(
                  flex: 1,
                  child: InfoBox(gradient: [Colors.brown, Colors.brown.withValues(alpha: 0.3)], text: 'Gender: ${_userProfileUI!.gender.name.capitalize}')
                    
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
