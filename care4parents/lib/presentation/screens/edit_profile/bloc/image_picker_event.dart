part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class GalleryImagePicked extends ImagePickerEvent {}

class CameraImagePicked extends ImagePickerEvent {}

class ImageDeleted extends ImagePickerEvent {}

class ImagePicked extends ImagePickerEvent {
  const ImagePicked(this.image);

  final File image;

  @override
  List<Object> get props => [image];
}
