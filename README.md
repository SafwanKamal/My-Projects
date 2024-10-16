# My-Projects

# Some Gameplay Snippets

## The GIFs might take a few seconds to load.


![Space Invader](https://github.com/SafwanKamal/My-Projects/assets/63901799/b4418fc1-e509-4606-a129-81a1feca2f60)
![Space Defender](https://github.com/SafwanKamal/My-Projects/assets/63901799/5e545711-eee9-4e21-ab65-f00749523be1)
![Asteroids](https://github.com/SafwanKamal/My-Projects/assets/63901799/f59a44cf-1458-46f8-8021-d8a0d6cd4560)
![Tank (2)](https://github.com/SafwanKamal/My-Projects/assets/63901799/94c9c111-2b9c-4d65-aa00-fafcfd60082d)
![PongAI](https://github.com/SafwanKamal/My-Projects/assets/63901799/36385036-6c6d-41f4-a049-f741fc0405f0)
![Pong2P](https://github.com/SafwanKamal/My-Projects/assets/63901799/661cc89f-ac6f-4799-b014-d43c92a1998d)
![TicTacToe-min](https://github.com/SafwanKamal/My-Projects/assets/63901799/038a5ca9-a334-45d8-9f62-5ad2c70b44ee)



# How to play the games:

You can PLAY all the games on itch.io: https://safka.itch.io/


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

#PongWithAI and #SpaceDefender were co-developed with @mubashirtanveerayon




