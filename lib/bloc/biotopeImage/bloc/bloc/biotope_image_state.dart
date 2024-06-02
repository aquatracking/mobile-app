part of 'biotope_image_bloc.dart';

enum BiotopeImageStatus { initial, loading, success, failure }

final class BiotopeImageState extends Equatable {
  const BiotopeImageState({
    this.status = BiotopeImageStatus.initial,
    this.biotopeImage,
  });

  final BiotopeImageStatus status;
  final Uint8List? biotopeImage;

  BiotopeImageState copyWith({
    BiotopeImageStatus Function()? status,
    Uint8List? Function()? biotopeImage,
  }) {
    return BiotopeImageState(
      status: status != null ? status() : this.status,
      biotopeImage: biotopeImage != null ? biotopeImage() : this.biotopeImage,
    );
  }

  @override
  List<Object?> get props => [status, biotopeImage];
}
