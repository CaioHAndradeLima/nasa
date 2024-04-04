
import 'package:localstore/localstore.dart';
import 'package:nasa_pictures/data/local/picture_local_filter.dart';
import 'package:nasa_pictures/data/model/nasa_picture.dart';
import '../../data/local/local_repository.dart';

class LocalRepositoryImpl extends LocalRepository {
  late final Localstore _instance;

  LocalRepositoryImpl({required Localstore instance}) {
    _instance = instance;
  }

  @override
  Future<List<NasaPicture>?> findPictures({PictureLocalFilter? filter}) async {
    final collection = _instance.collection('picture');
    final data = await collection.get();

    if(data != null) {
      final pictures = data.values.map((picture) => NasaPicture.fromMap(picture)).toList();
      return filter?.applyFilter(pictures) ?? pictures;
    }

    return null;
  }

  @override
  Future<NasaPicture?> findOnePicture(String id) async {
    final data = await _instance.collection('picture').doc(id).get();

    if(data != null) {
      return NasaPicture.fromMap(data);
    }

    return null;
  }

  @override
  Future<void> insertAll(List<NasaPicture> pictures) async {
    for (var picture in pictures) {
      await _instance.collection('picture').doc(picture.id).set(
          picture.toMap()
      );
    }
  }

  @override
  Future<void> deleteAll() async {
    _instance.collection('pictures').delete();
  }
}