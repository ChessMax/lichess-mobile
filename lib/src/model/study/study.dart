import 'package:collection/collection.dart';
import 'package:dartchess/dartchess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichess_mobile/src/model/common/chess.dart';
import 'package:lichess_mobile/src/model/common/id.dart';
import 'package:lichess_mobile/src/model/user/user.dart';

part 'study.freezed.dart';
part 'study.g.dart';

@Freezed(fromJson: true)
class Study with _$Study {
  const Study._();

  const factory Study({
    required StudyId id,
    required String name,
    required ({StudyChapterId chapterId, String path}) position,
    required bool liked,
    required int likes,
    required UserId? ownerId,
    @JsonKey(fromJson: studyFeaturesFromJson) required StudyFeatures features,
    required IList<String> topics,
    required IList<StudyChapterMeta> chapters,
    required StudyChapter chapter,
  }) = _Study;

  StudyChapterMeta get currentChapterMeta =>
      chapters.firstWhere((c) => c.id == chapter.id);

  factory Study.fromJson(Map<String, Object?> json) => _$StudyFromJson(json);
}

typedef StudyFeatures = ({
  bool cloneable,
  bool chat,
  bool sticky,
});

StudyFeatures studyFeaturesFromJson(Map<String, Object?> json) {
  return (
    cloneable: json['cloneable'] as bool? ?? false,
    chat: json['chat'] as bool? ?? false,
    sticky: json['sticky'] as bool? ?? false,
  );
}

@Freezed(fromJson: true)
class StudyChapter with _$StudyChapter {
  const StudyChapter._();

  const factory StudyChapter({
    required StudyChapterId id,
    required StudyChapterSetup setup,
    @JsonKey(defaultValue: false) required bool practise,
    required int? conceal,
    @JsonKey(defaultValue: false) required bool gamebook,
    @JsonKey(fromJson: studyChapterFeaturesFromJson)
    required StudyChapterFeatures features,
  }) = _StudyChapter;

  factory StudyChapter.fromJson(Map<String, Object?> json) =>
      _$StudyChapterFromJson(json);
}

typedef StudyChapterFeatures = ({
  bool computer,
  bool explorer,
});

StudyChapterFeatures studyChapterFeaturesFromJson(Map<String, Object?> json) {
  return (
    computer: json['computer'] as bool? ?? false,
    explorer: json['explorer'] as bool? ?? false,
  );
}

@Freezed(fromJson: true)
class StudyChapterSetup with _$StudyChapterSetup {
  const StudyChapterSetup._();

  const factory StudyChapterSetup({
    required GameId? id,
    required Side orientation,
    @JsonKey(fromJson: _variantFromJson) required Variant variant,
    required bool? fromFen,
  }) = _StudyChapterSetup;

  factory StudyChapterSetup.fromJson(Map<String, Object?> json) =>
      _$StudyChapterSetupFromJson(json);
}

Variant _variantFromJson(Map<String, Object?> json) {
  return Variant.values.firstWhereOrNull(
    (v) => v.name == json['key'],
  )!;
}

@Freezed(fromJson: true)
class StudyChapterMeta with _$StudyChapterMeta {
  const StudyChapterMeta._();

  const factory StudyChapterMeta({
    required StudyChapterId id,
    required String name,
    required String? fen,
  }) = _StudyChapterMeta;

  factory StudyChapterMeta.fromJson(Map<String, Object?> json) =>
      _$StudyChapterMetaFromJson(json);
}

@Freezed(fromJson: true)
class StudyPageData with _$StudyPageData {
  const StudyPageData._();

  const factory StudyPageData({
    required StudyId id,
    required String name,
    required bool liked,
    required int likes,
    @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
    required DateTime updatedAt,
    required LightUser? owner,
    required IList<String> topics,
    required IList<StudyMember> members,
    required IList<String> chapters,
    required String? flair,
  }) = _StudyPageData;

  factory StudyPageData.fromJson(Map<String, Object?> json) =>
      _$StudyPageDataFromJson(json);
}

@Freezed(fromJson: true)
class StudyMember with _$StudyMember {
  const StudyMember._();

  const factory StudyMember({
    required LightUser user,
    required String role,
  }) = _StudyMember;

  factory StudyMember.fromJson(Map<String, Object?> json) =>
      _$StudyMemberFromJson(json);
}
