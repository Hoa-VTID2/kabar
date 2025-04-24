import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/domain/entities/comment.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/pages/comment/comment_controller.dart';
import 'package:kabar/presentation/views/pages/comment/comment_state.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_text_field.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:kabar/shared/extensions/datetime_extensions.dart';
import 'package:kabar/shared/extensions/int_extensions.dart';
import 'package:kabar/shared/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CommentPage extends BasePage<CommentController, CommentState> {
  const CommentPage(this.newsId, {super.key});

  final int newsId;

  @override
  void onInitState(BuildContext context) {
    context.read<CommentController>().initCommentData(newsId);
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return RefreshIndicator(
      onRefresh: ()async {
        await Future.delayed(const Duration(milliseconds: 500));
        context.read<CommentController>().initCommentData(newsId);
      },
      child: Consumer<CommentState>(builder: (context, state, child) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: SvgPicture.asset(Assets.icons.back.path),
                          onTap: () => context.pop(),
                        ),
                        Expanded(
                            child: Center(
                          child: Text(
                            LocaleKeys.comment_title.tr(),
                            style: context.themeOwn().textTheme?.textMedium,
                          ),
                        )),
                      ],
                    ),
                    const Gap(17),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.comments
                            .where(
                              (element) => element.replyCommentId == -1,
                            )
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          return CommentCard(
                              comment: state.comments
                                  .where(
                                    (element) => element.replyCommentId == -1,
                                  )
                                  .toList()[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                      top: BorderSide(
                    color: Colors.transparent,
                  )),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(128, 128, 128, 0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, -1),
                    ),
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        if (state.replyTo != -1)
                          Row(
                            children: [
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                '${LocaleKeys.comment_reply.tr().uppercaseFirstLetter()} ${state.users.firstWhere(
                                      (element) =>
                                          state.comments
                                              .firstWhere(
                                                (element) =>
                                                    element.id == state.replyTo,
                                              )
                                              .userId ==
                                          element.id,
                                    ).fullName}',
                                style: context
                                    .themeOwn()
                                    .textTheme
                                    ?.linkMedium
                                    ?.copyWith(color: AppColors.primaryColor),
                              ),
                              Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<CommentController>()
                                          .updateReply(-1);
                                    },
                                    child: Text(
                                      LocaleKeys.comment_cancel.tr(),
                                      style: context
                                          .themeOwn()
                                          .textTheme
                                          ?.linkMedium
                                          ?.copyWith(color: AppColors.errorColor),
                                      textAlign: TextAlign.start,
                                    )),
                              )
                            ],
                          ),
                        AppTextField(
                          value: state.content,
                          onChanged: (value) {
                            context
                                .read<CommentController>()
                                .updateContent(value);
                          },
                          hint: LocaleKeys.comment_place_holder.tr(),
                        ),
                      ],
                    ),
                  ),
                  //const Expanded(child: Gap(0)),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CommentController>().sendComment();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(AppColors.primaryColor),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                        padding: const WidgetStatePropertyAll(
                            EdgeInsets.fromLTRB(8, 4, 8, 4)),
                      ),
                      child: Assets.icons.send.svg(),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentState>(builder: (context, state, child) {
      int maxId = 0;
      for (Comment e in state.comments) {
        if (e.replyCommentId == comment.id) {
          maxId = max(e.id, maxId);
        }
      }
      return Column(
        children: [
          singleComment(
              state.users.elementAt(comment.userId - 1), comment, context),
          if (state.comments
              .where(
                (element) => element.replyCommentId == comment.id,
              )
              .toList()
              .isNotEmpty)
            if (state.showSubs[comment.id] ?? false)
              ...state.comments
                  .where(
                (element) => element.replyCommentId == comment.id,
              )
                  .map((e) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 51,
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      width: 2, color: Color(0xFFf1f1f1)),
                                  bottom: BorderSide(
                                      width: 2, color: Color(0xFFf1f1f1))),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8)),
                              //color: AppColors.errorColorLight
                            ),
                            margin: const EdgeInsets.fromLTRB(27, 0, 0, 0),
                          ),
                        ),
                        if (e.id != maxId)
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      width: 2, color: Color(0xFFf1f1f1)),
                                  bottom: BorderSide(
                                      width: 2, color: Color(0xFFf1f1f1))),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8)),
                              //color: AppColors.errorColorLight
                            ),
                            margin: const EdgeInsets.fromLTRB(27, 0, 0, 0),
                            height: 91.5,
                          )
                      ],
                    ),
                    Expanded(
                        child: singleComment(
                            state.users.elementAt(e.userId - 1), e, context))
                  ],
                );
              })
            else
              Row(
                children: [
                  const SizedBox(
                    width: 51,
                  ),
                  InkWell(
                    onTap: () {
                      context.read<CommentController>().showSub(comment.id);
                    },
                    child: Text(
                      '${LocaleKeys.comment_see_more.tr()} (${state.comments.where(
                            (element) => element.replyCommentId == comment.id,
                          ).toList().length})',
                      style: context
                          .themeOwn()
                          .textTheme
                          ?.textMedium
                          ?.copyWith(color: AppColors.subTextColor),
                    ),
                  )
                ],
              ),
          // if (state.comments
          //     .where(
          //       (element) => element.replyCommentId == comment.id,
          //     )
          //     .toList()
          //     .isNotEmpty)
          //   if (state.showSubs[comment.id])
          //     Row(
          //       children: [
          //         const SizedBox(
          //           width: 51,
          //         ),
          //         InkWell(
          //           onTap: () {
          //             context.read<CommentController>().hideSub(comment.id);
          //           },
          //           child: Text(
          //             '${LocaleKeys.comment_hide.tr()} ',
          //             style: context
          //                 .themeOwn()
          //                 .textTheme
          //                 ?.textMedium
          //                 ?.copyWith(color: AppColors.subTextColor),
          //           ),
          //         )
          //       ],
          //     )
        ],
      );
    });
  }

  Widget singleComment(UserInfo user, Comment comment, BuildContext context) {
    return Consumer<CommentState>(builder: (_, state, __) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Column(
              children: [
                Image.asset(
                  user.image,
                  width: 40,
                  height: 40,
                ),
                const Gap(8),
                if (state.showSubs[comment.id] ?? false)
                  Container(
                    height: 66,
                    decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Color(0xFFf1f1f1)),
                          right: BorderSide(color: Color(0xFFf1f1f1))),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: context.themeOwn().textTheme?.linkMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    comment.content,
                    style: context.themeOwn().textTheme?.textMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    spacing: 12,
                    children: [
                      Text(
                        comment.sendAt.getTimeAgoWithoutAgo,
                        style: context
                            .themeOwn()
                            .textTheme
                            ?.textXSmall
                            ?.copyWith(color: AppColors.subTextColor),
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          if (comment.liked)
                            InkWell(
                                onTap: () {
                                  context
                                      .read<CommentController>()
                                      .unLikeComment(comment.id);
                                },
                                child: Assets.icons.heart
                                    .svg(width: 14, height: 14))
                          else
                            InkWell(
                                onTap: () {
                                  context
                                      .read<CommentController>()
                                      .likeComment(comment.id);
                                },
                                child: Assets.icons.heartOutline
                                    .svg(width: 14, height: 14)),
                          Text(
                            '${comment.likes.shortNumber} ${LocaleKeys.comment_likes.tr()}',
                            style: context
                                .themeOwn()
                                .textTheme
                                ?.textXSmall
                                ?.copyWith(color: AppColors.subTextColor),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if (comment.replyCommentId == -1) {
                            context
                                .read<CommentController>()
                                .updateReply(comment.id);
                          } else {
                            context
                                .read<CommentController>()
                                .updateReply(comment.replyCommentId);
                          }
                        },
                        child: Row(
                          spacing: 4,
                          children: [
                            Assets.icons.reply.svg(),
                            Text(
                              LocaleKeys.comment_reply.tr(),
                              style: context
                                  .themeOwn()
                                  .textTheme
                                  ?.textXSmall
                                  ?.copyWith(color: AppColors.subTextColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
