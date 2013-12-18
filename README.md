Backscratcher Game from the ITP Show Winter 2013

This is a game for Processing 2.1.

To play in an ideal situation, you will need:

An ordinary backscratcher
A brightly colored peice of tape to put on the backscratcher
A USB webcam with a long cord and/or a USB extension cord, or a mirror, maybe
You don't need all those items to play, but without them, you're just killing spiders with your mouse, which is infinitely less fun.

If you do want to play the game with a backscratcher, set up your camera so it's behind you, so you can see your own back on your computer screen (or projector or monitor).

When you launch the game for the first time, Processing lists the available cameras. If you're on a laptop, the internal webcam is probably zero. In my case, external webcams tended to be listed at 15. You need to manually change the number of the camera in the sketch to the camera you intend to use.

You also need to change the sketch size in the setup loop to match your camera's resolution.

Once you've got your camera up and running, there are two steps to setting up the game to start:

Click and drag from left to right to draw a box around the player's back. So first click on their left shoulder, and then drag down diagonally to the right. The program counts mouse clicks, so it's important to only click twice.
Next, have the player hold the backscratcher so you the camera can "see" the colored tape. Click on that color, and that will be the color that gets tracked and used as a weapon.
The sketch is set up so you can use the mouse in case the color tracker doesn't work.

The color tracker works best with adequate lighting and as few competing colors as possible. For example, if you put a black dot on the backscratcher and have black hair, the color tracker will jump back and forth from the backscratcher to your hair. Any black objects also in the frame will cause the color tracker to be inaccurate.

This code (as of Dec. 17, 2013) has some problems, and I hope github can help me out.
