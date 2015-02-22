## Twitter

This is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: `10`

### Features

#### Required

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
  - **Note**: Implemented this by adding controls to the table view cell.  The first control (reply) has a fixed height constraint.  The others have an equal height constraint to the first.  Using an `IBOutlet` for the fixed height constraint, it could be set to zero initially.  On selection, the constraint could be updated and the changed table cells (newly selected and previously selected) are reloaded.
- [ ] User can retweet, favorite, and reply to the tweet directly from the timeline feed.

#### Problems

- The tweet text in the table cell doesn't wrap until the cell is scrolled away and then back, or the device orientation changes.  I set `preferredMaxLayoutWidth` in `awakeFromNib` and `layoutSubviews`.  I tried playing with various constraints and priorities, but never did get it working correctly.

#### Optional

- [ ] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

### Walkthrough

![Video Walkthrough](...)
