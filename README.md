# My-Projects

# How to play the games:

You can play the games at gotm.io. Here are the links:

## SPACE INVADER: https://gotm.io/safwankamal/spacedefender

## SPACE DEFENDER: https://gotm.io/safwankamal/space-defender

## ATTACK OF THE SLIMES: https://gotm.io/safwankamal/attack-of-the-slimes

## PongAI: https://gotm.io/safwankamal/pongai

## Pong2P: https://gotm.io/safwankamal/pong2p

# Some Gameplay Snippets


![SpaceInvader](https://github.com/SafwanKamal/My-Projects/assets/63901799/1a20317c-304b-4504-beed-dbc54b1e7ac4)




![Tank](https://github.com/SafwanKamal/My-Projects/assets/63901799/285795bf-84e9-4af2-95a6-f1afa378ed07)

![PongAI](https://github.com/SafwanKamal/My-Projects/assets/63901799/a517507e-68ec-42e7-b782-6c1704f9fc00)

![Pong2P](https://github.com/SafwanKamal/My-Projects/assets/63901799/54d27f78-37f6-4904-bb21-89d06640b64f)


# Resources 

Most of the art has been sourced from Kenny (https://www.kenney.nl/)

The PIXEL ART for Space Defender has been done by me with the use of Asprite. 


# Questions 

## Why were these games made?

These games were made to be the 'tutorial' and 'capstone' projects for a book that was planned to be developed for kids in the age bracket of 10-15. The book's goal was to introduce kids to basic game development in Bangla. 

## What is the wider vision of the project?

The project was undertaken to address the problems that I faced when learning about programming as a student whose first language is Bangla. There are many primary-level resources for getting one started on this path. However, when one tries to improve his/her skill to a greater extent or specialize in a particular facet of programming and development, then the number of resources is virtually zero. So this initiative was taken to give a stepping stone for those who wanted to dedicate more to their programming skills, while also making the process fun and smooth. 

## How many games were supposed to be made?

Initially, five games would have been included. Tic-tac-toe, Connect4, Snake, Space Shooter, and a Platformer. Later, a 3D game was also planned. 

## Why was Godot Game engine used?

Godot game engine was chosen because it is free, open-source, lightweight, clutter-free, and suitable for 2D game development. Its proprietary language 'GDScript' is python-like in terms of its syntax- which is relatively easy for newcomers. 

## What is the current state of the project?

At first, the work on the project ran smoothly. But, for unforeseen reasons during the pandemic, I had to stop the development of this project. The project will be restarted if appropriate time and resources can be allotted again.



# Book Dev Ideas 

I will list some of the points and ideas that were planned for the book.

# Ideas about Tic-tac-toe

It is a very simple game. However, this game was selected as a good introduction to both the game engine that was used in this project (GODOT) and game theory. The graphical interface for the game is simple, giving more time for familiarization with the engine. The game theory concept discussed here will be easily discernable, yet very important for many of the games we know like connect4, chess, go, etc. 

## Evaluation Function

The evaluation function for Tic-tac-toe is uncomplicated. The final state of the game is WIN, LOSE, or Draw. And the DFS (Depth First Search) graph depth is minimal. So additional attribution of points to 'optimal moves' or 'optimal intermediary steps' will also be unnecessary. So, WIN -> 1, LOSE -> -1, and Draw -> 0 will be returned when the game evaluation function reaches the possible end states of the game. The program will choose to maximize the number of winning paths through a certain move, i.e. the sum of the return values of all evaluated states will be maximum. 

## Tic-tac-toe AI ideas

### Brute force Approach: The first approach that comes to mind for a simple game like this is to use the brute computing power a computer has to evaluate  


# Sidenote

You will find the executables of the projects at the following drive link:

https://drive.google.com/drive/folders/17TLVSNE-A79vwRG5YJeUJo6B7MFOogl0?usp=sharing

Please be warned that Windows will flag these .exe files to be "dangerous" or block them from running. You have to give permission from the anti-virus software you are using to run these files. 

You can also download the Godot game engine and run the programs inside the engine by downloading the project files here at Git Hub. 

For most of the projects, Godot version 3.5 can be used to open them. Godot version 4 has introduced significant changes that affect backward compatibility. 


## Appreciation 

PondWithAI and #SpaceDefender were co-developed with @mubashirtanveerayon




