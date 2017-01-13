Last updated:    14-05-2014
Release version: 1.0
Author:          Alberto Taiuti - 1300250 CGT
------------------------------------------------------------------------



###Table of contents
-----------------
1. About
2. Concept Design and Development
 * Pitch
 * Target audience and genre
3. Supported platforms
4. Installing and running 
 * How to play
 * Winning condition
 * Losing condition
5. Directory structure
 * leaf-framework
 * Klash
6. Points of improvement
7. Credits


Play the game: http://www.albertotaiuti.com/klash_play.php




### 1.0) About
---- -----
Klash is an arcade platformer videogame inspired by classics such as Super Mario Bros 
(Nintendo, 1985) and more modern games such as Super Crate Box (Vlambeer, 2010).
It attempts to mimic the feeling given by old 8-bit platforms, while extending
the mechanics thanks to the tools available nowadays.

It features the leaf-framework, an engine written in AS3 by Alberto Taiuti which
bypasses AS3's classical structure for events and displayObjects; 
instead, it uses raw bitmaps manipulation for rendering the objects and scenes, 
achieving a huge leap forward in speed performance.

The current build represents a demo, with one level available. It has been developed
as the coursework for the module Media Production for Games at The University Of
Abertay Dundee by Alberto Taiuti.





### 2.0) Concept Design and Development
---- ------------------------------
Klash has been developed with the objective of realising a demo which could show most
of the game mechanics thought during the brainstorming phase of the development.

The brainstorming and definition of game elements and mechanics was accomplished using
Microsoft OneNote

	  
### 2.1) Pitch
---- -----
Klash is a challenging, retro-style 2D platformer about Raphael, the son of a famous 
and important Doctor who, after a wild party in a countryside villa and a few too many
drinks, wakes up alone in the mansion and finds himself in the struggle of survival while
trying to make it back to reality.
This becomes increasingly challenging because every level enemies become stronger and the
collectibles harder to reach.


### 2.2) Target audience and genre
---- -------------------------
The game is aimed to a mixed pool of players: its retro-style, nostalgic graphics and 
sound effects will attract players aged from 30 years old onward, whereas the challenging 
mechanics and compelling plot will attract teenagers (the game does not present any 
gore scene, it can be aimed to this pool of audience too). 
The genre is a 2D side scrolling platformer inspired by classics Super Mario Bros 
(Nintendo, 1985) and more modern games such as Super Crate Box (Vlambeer, 2010).





### 3.0) Supported platforms
---- -------------------
Platforms currently being supported are Browser and local Flash Player.





### 4.0) Installing and running 
---- ----------------------
The game comes as a .swc file which can be opened using any modern browser or by using
the stand-alone Adobe's SWC player on Windows, Mac and Linux.


### 4.1) How to play
---- -----------
Once the game started, the menu tells the user the available choices:
 - By pressing "S" the game will first show the player the controls and after pressing
 "S" again, the game will start;
 - By pressing "C" the game will show a credits section. Pressing "C" again will bring 
 the user back to the main menu
 
 - Once in-game, the main character can be controlled by using the arrow keys for 
 movement, and "X" and "C" respectively for jumping and shooting.
 There are 3 types of enemies and 4 different collectibles.
 The player gets hurt by colliding either with the spikes or with the enemies.

 
### 4.2) Winning condition
---- -----------------
In order to beat the demo, the player needs to kill every single enemy and collect all the 
collectibles.


### 4.3) Losing condition
---- ----------------
When the player's health reaches 0, the game will be over and it will be possible to try
again.





### 5.0) Directory structure
---- -------------------
 # All the source files can be found inside the /src folder; 
 # the /bin folder contains the .swc compiled build of the game;
 # the /assets folder contains the graphical and audio assets of the game
 # the /obj folder contains FlashDevelop's own configuration files

The /src folder's structure can be sub-divided into two main sections, the engine section
and the game section. They are respectively found at (5.1) and (5.2).


### 5.1) leaf-framework
---- --------------
The /leaffmk folder contains the source files of the leaf-framework; the leaf-framework itself
presents a folder structure which states exactly which genre of source files to find inside. 
In the leaf-framework, only a bitmap object acting as buffer is added to the stage, 
therefore everything else is rendered on this bitmap accessible everywhere in the code.
Using this method the performance is highly improved.

A basic UML representation of the framework can be found here: http://goo.gl/X40R3x
*IMPORANT*: this representation is not the structure of the latest version; it serves only as 
a template for understanding the fundamental parts of the framework

This folder structure is 
	/collisions: classes used for collision detection
	/custom_events: events created inheriting from AS3's built-in ones; they are used in various
		parts of the engine, such as state-state communication and entity-engine communication
	/entities: class of the basic object with properties which can be shared by all the inherited
		entities
	/graphics: contains the renderManager, which is the manager responsible of drawing everything
		on the buffer added to the stage every frame. It also contains the camera class and the 
		background class
	/input: contains the keyboard an mouse classes; both of these classes are a replacement to the
		built-in ones in order to make them work with the custom structure of the leaf-framework.
		Their interface makes them very similar to the built-in ones, allowing for an easy interchange
		between the two when needed.
	/map: utility classes for loading into the game a map created with Tiled Map Editor
	/maths: vector2d class
	/states: basic state class used to derive all the child states found in the game
	/UI: basic UI replacements to AS3's built-in ones, which are then used in the game by creating 
		children classes
	

### 5.2) Klash
---- -----
The game's source files are located outside the leaf-framework's folder structure and heavily use
the classes from the framework. Most of them are children of classes in the leaf-framework.

The folder structure is basically the same as the one for the framework.





### 6.0) Points of improvement
---- ---------------------
The leaf-framework represents a great starting point and it need some polish. 
Nonetheless, the overall result is good and the game could be improved by
adding more levels, more enemies and more mechanics such as diving under 
water and getting power-ups.





X.X) Credits
---- -------
Graphics by: http://opengameart.org/content/simple-broad-purpose-tileset
Audio by: http://www.8bitpeoples.com/discography?page=2
