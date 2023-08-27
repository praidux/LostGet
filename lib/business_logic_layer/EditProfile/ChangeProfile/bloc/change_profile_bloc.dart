import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'change_profile_event.dart';
part 'change_profile_state.dart';

class ChangeProfileBloc extends Bloc<ChangeProfileEvent, ChangeProfileState> {
  ChangeProfileBloc() : super(ChangeProfileInitialState()) {
    on<ChangeProfile>((event, emit) async {
      emit(ChangeProfileLoadingState());
      ImagePicker picker = ImagePicker();

      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        print("Image is her ${image.name}");
        emit(ChangeProfileLoadedState(image));
      } else {
        emit(const ChangeProfileErrorState("Error Occurred"));
      }
    });
  }
}
