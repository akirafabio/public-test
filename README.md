### Create a local git repository to track your work and send it to us when finished.

1. AboutViewController doesn't close when tapping the (x) button. Fix the bug.
2. Add a new button titled "TO-DO: #" above the "About" button, and vertically center both buttons in the view. The "TO-DO" button will take the user to a new screen that contains a simple TO-DO list. The title of the button should reflect the number of items on the list, f.e. "TO-DO: 10". See the requirements for the TO-DO list below.

#### TO-DO list:
1. The navigation bar contains a button to go back on the left, and a button to add a task to the list on the right (+).
2. Tapping the + button simply opens an alert with a text field that lets the user enter the task name (up to 50 characters long).
3. The user can cancel or save the task. Cancelling simply dismisses the prompt. Saving the task dismisses the prompt immediately and inserts the task at the top of the list. There should be an activity indicator next to the task name, to indicate the task is still being saved (see next point).
4. On the background, add a random delay between 500 and 5000 milliseconds that simulates a network call. After this delay, the task can either succeed or fail. Make it randomly fail, with a success rate of 75%.
	* If it succeeds, reflect this in the UI by removing the activity indicator.
	* If it fails, set the task text color to red and remove it from the list after 1 second.
5. Each task on the list (if it has been successfully saved) has an X button on the trailing side to delete it. Tapping the button removes the task from the list, without confirmation.
