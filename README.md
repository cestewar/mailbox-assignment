# Mailbox

Mailbox week 3 assignment for Cameron Stewart's Codepath.

Time spent: ~11.5 hours spent in total (aside from the 3+ hours trying to figure out github)

Completed user stories:

On dragging the message left...
* [x] Initially, the revealed background color should be gray.
* [x] As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
* [x] After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
* [x] Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
* [x] After 260 pts, the icon should change to the list icon and the background color should change to brown.
* [x] Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
* [x] User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.

On dragging the message right...
* [x] Initially, the revealed background color should be gray.
* [x] As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
* [x] After 60 pts, the archive icon should start moving with the translation and the background should change to green.
* [x] Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
* [x] After 260 pts, the icon should change to the delete icon and the background color should change to red.
* [x] Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.

* [x] Optional: Panning from the edge should reveal the menu
* [x] Optional: If the menu is being revealed when the user lifts their finger, it should continue revealing.
* [x] Optional: If the menu is being hidden when the user lifts their finger, it should continue hiding.

 
Notes:

Some thoughts of mine while doing this:
* "There's got to be a way to store all of these animations so I don't have to keep writing them"
* "With the edge gesture used to initially drag the container to the right, is there a way to leverage the same gesture to bring the container
back to position? Or would I have to add another gesture?"
* "Github is confusing as hell."

Walkthrough of all user stories:

![Mailbox](mailbox.gif)


