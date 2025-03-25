enum UserAction {
  posted,
  follow,
  comment,
  like,
}

const Map<UserAction, String> ActionDetail = {
  UserAction.posted: ' has posted new ',
  UserAction.follow: ' is now following you',
  UserAction.comment: ' comment to your news ',
  UserAction.like: ' likes your news ',
};
