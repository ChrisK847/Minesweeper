# Minesweeper
This is the start of my own version of Minesweeper.

To play the game, run the MineSweeper17.0.1.ps1 file. MineSweeper17.0.1.ps1 seemed to work okay. v16.5.8.9 works, but the music resets after each round. v17.0.5 breaks at end-of-round. I'm not sure if it matters, but the folder on my PC is stored at D:\MineSweeper, so if there are any static links, which I hope I don't have any, you may want to store the game on a thumb drive, like how I have it stored.

This game has music and images, it allows you to create and save a profile, allows you to set your game difficulty and field size, and allows you to right-click to mark where you think a bomb is.

Here's a video demo of an older version of the game I uploaded last year:
https://www.youtube.com/watch?v=khHWd-3-Lh8

I am looking for help to finish off the Windows Media Player Class (WMP) functionality, so that music plays through a playlist and it gets paused when a bomb explodes or when the end-of-round music plays. The last updates, v17.0.5, I added actually intermittently break the game at end-of-round, aka, when a bomb explodes or when you beat the round. I may just need to upload an older game for contrast and compare. The reason I'm looking for help is because the WMP logic just seems like it requires too many variations, meaning, there may be 24 if not 70+ combinations of when the music should stop or start, or pause, or play during gameplay. On top of all those possible variations, each may require 1 to 3 additional steps to complete their cycle. I think part of this may be due to the fact that the WMP event that is supposed to trigger when media ends doesn't work, at least I haven't figured out how to make it work and nobody online has figured it out either. One person actually replied to another's post "why do you assume the event actually works"? So, I created a workaround to determine when the media ends by using other WMP properties. When I get the time and determination to work on this further I'll create a video and walk you through the code and where I'm hung up on.
