part of '../../classrooms_logic.dart';

abstract class GradeChoosingRemoteDataSource {
  Future<GradeChoosingModel> gradeChoosing(
      {required GradeChoosingParameters parameters});

  Future<List<StudyingModel>> getSystemsId();

  Future<List<StudyingModel>> getStages({required int systemId});

  Future<List<StudyingModel>> getClassRoom({
    required GetClassRoomParameter getClassRoomParameter,
  });

  Future<List<StudyingModel>> getTerms({
    required GetTermsParameters parameters,
  });

  Future<List<StudyingModel>> getPaths({
    required GetPathParameters parameters,
  });
}

@LazySingleton(as: GradeChoosingRemoteDataSource)
class GradeChoosingRemoteDataSourceImpl
    implements GradeChoosingRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  GradeChoosingRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<GradeChoosingModel> gradeChoosing(
      {required GradeChoosingParameters parameters}) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.gradeSelectionPath,
      body: {
        "system_id": parameters.systemId,
        "stage_id": parameters.stageId,
        "classroom_id": parameters.classRoomId,
        "term_id": parameters.termId,
        "path_id": parameters.pathId == 0 ? null : parameters.pathId,
      },
    );
    return GradeChoosingModel.fromJson(response);
  }

  @override
  Future<List<StudyingModel>> getSystemsId() async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.systemPath,
      body: {},
    );
    return List<StudyingModel>.from((response['data'] as List)
        .map((element) => StudyingModel.fromJson(element)));
  }

  @override
  Future<List<StudyingModel>> getStages({required int systemId}) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.stagesPath,
      body: {
        'system_id': systemId,
      },
    );

    return List<StudyingModel>.from((response['data'] as List)
        .map((element) => StudyingModel.fromJson(element)));
  }

  @override
  Future<List<StudyingModel>> getClassRoom(
      {required GetClassRoomParameter getClassRoomParameter}) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.classroomsPath,
      body: {
        'stage_id': getClassRoomParameter.stageId,
      },
    );

    List<PathsInClassroomModel> paths = [];
    response['data'].forEach((element) {
      if (element['paths'].isNotEmpty) {
        element['paths'].forEach((element) => paths.add(
              PathsInClassroomModel(
                  pathId: element['id'], pathName: element['name']),
            ));
      }
    });

    return List<StudyingModel>.from(
      (response['data'] as List).map(
        (element) {
          paths = [];
            if (element['paths'].isNotEmpty) {
              element['paths'].forEach((element) => paths.add(
                PathsInClassroomModel(
                    pathId: element['id'], pathName: element['name']),
              ));
            }
          return StudyingModel(
          id: element['id'],
          name: element['name'],
          price: element['price'],
          isPath: element['paths'].isNotEmpty ? true : false,
          paths: paths,
        );
        },
      ),
    );
  }

  @override
  Future<List<StudyingModel>> getTerms({
    required GetTermsParameters parameters,
  }) async {
    final response =
        await baseRemoteDataSource.postData(url: EndPoints.termsPath, body: {

      'classroom_id': parameters.classRoomId,
    });
    return List<StudyingModel>.from((response['data'] as List)
        .map((element) => StudyingModel.fromJson(element)));
  }

  @override
  Future<List<StudyingModel>> getPaths(
      {required GetPathParameters parameters}) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.pathPath,
      body: {
        'classroom_id': parameters.classRoomId,
      },
    );
    return List<StudyingModel>.from((response['data'] as List)
        .map((element) => StudyingModel.fromJson(element)));
  }
}
