## Twitter Redux

This is a twitter app to read and compose tweets which uses a hamburger menu.

Time spent: `6`

### Features

#### Required

- Hamburger menu
  - [x] Dragging anywhere in the view should reveal the menu.
  - [x] The menu should include links to your profile, the home timeline, and the mentions view.
  - [x] The menu can look similar to the LinkedIn menu below or feel free to take liberty with the UI.
- Profile page
  - [x] Contains the user header view
  - [x] Contains a section with the users basic stats: # tweets, # following, # followers
- Home Timeline
  - [x] Tapping on a user image should bring up that user's profile page

#### Highs

- I was pleasantly suprised by how easy this assignment was :)
- I was able to reuse the home timeline controller for mentions fairly easily

#### Lows

- It was a bit tricky getting consistent navigation controllers when using the hamburger menu
- I could have made the hamburger menu more generic, instead of hard coding the menu items and slidable views
- I used the same view controller for home timeline and mentions, but this was done in a hacky way.  I could have made a delegate protocol.  I wanted to get started on my group project instead though.

### Walkthrough

![Video Walkthrough](https://raw.githubusercontent.com/d5h/ios_twitter_hamburger/master/twitter.gif)
