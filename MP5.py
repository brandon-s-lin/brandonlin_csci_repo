#
# Machine Problem 5 (MP5): Animation
# 
# Brandon Lin
#
# Description: This script creates a graphics scene using cslgraphics. 
#              The initial scene includes a sky, grass, a tree (a 
#              Layer object), and one “animal” (also a Layer object) 
#              on screen. The tree and the animal are “complicated 
#              objects” made from multiple shapes. A second animal (a 
#              clone of the first) enters from the right side, pushes 
#              the first animal off screen, then exits itself. 
#              Meanwhile, a cloud is moving across the sky. By the end,
#              only one animal remains on the scene.
#

from cs1graphics import *
from time import sleep

def makeSky(canvasWidth, canvasHeight):
    """
    Creates a Rectangle that acts as the 'sky' background.
    
    Returns:
        Rectangle: A rectangle spanning the entire Canvas to simulate
        sky.
    """
    sky = Rectangle(canvasWidth, canvasHeight, Point(canvasWidth/2, 
                                                     canvasHeight/2))
    sky.setFillColor('lightBlue')
    sky.setBorderColor('lightBlue')
    return sky

def makeGrass():
    """
    Creates a green Rectangle for the 'grass' at the bottom portion of 
    the scene.
    
    Returns:
        Rectangle: A rectangle to represent grass area.
    """
    grass = Rectangle(800, 200, Point(400, 500))
    grass.setFillColor('darkgreen')
    grass.setBorderColor('darkgreen')
    return grass

def makeTree():
    """
    Creates and returns a Layer object that represents a tree.
    Includes trunk (rectangle), branches, and leaves (circles).
    
    Returns:
        Layer: A Layer containing all parts of the tree.
    """
    tree = Layer()
    
    trunk = Rectangle(40, 100, Point(0, 0))
    trunk.setFillColor('saddlebrown')
    trunk.setBorderColor('saddlebrown')
    
    leaf1 = Circle(30, Point(0, -50))
    leaf1.setFillColor('forestgreen')
    leaf1.setBorderColor('forestgreen')

    leaf2 = Circle(25, Point(-20, -80))
    leaf2.setFillColor('forestgreen')
    leaf2.setBorderColor('forestgreen')

    leaf3 = Circle(25, Point(20, -80))
    leaf3.setFillColor('forestgreen')
    leaf3.setBorderColor('forestgreen')

    leaf4 = Circle(30, Point(0, -10))
    leaf4.setFillColor('forestgreen')
    leaf4.setBorderColor('forestgreen')

    leaf5 = Circle(25, Point(-20, -10))
    leaf5.setFillColor('forestgreen')
    leaf5.setBorderColor('forestgreen')

    leaf6 = Circle(25, Point(20, -30))
    leaf6.setFillColor('forestgreen')
    leaf6.setBorderColor('forestgreen')

    leaf7 = Circle(25, Point(-40, -30))
    leaf7.setFillColor('forestgreen')
    leaf7.setBorderColor('forestgreen')

    tree.add(trunk)
    tree.add(leaf1)
    tree.add(leaf2)
    tree.add(leaf3)
    tree.add(leaf4)
    tree.add(leaf5)
    tree.add(leaf6)
    tree.add(leaf7)
    return tree

def makeAnimal():
    """
    Creates and returns a Layer object that represents an 'animal.'
    This might be something simple like a 'bull,' 'dog,' 'bird,' 
    etc., made from multiple shapes.
    
    Returns:
        Layer: A Layer with multiple shapes forming an animal.
    """
    animal = Layer()
    
    body = Ellipse(80, 40, Point(0, 0))
    body.setFillColor('gray')
    body.setBorderColor('black')

    head = Circle(15, Point(40, 0))
    head.setFillColor('gray')
    head.setBorderColor('black')

    eye1 = Circle(2, Point(35,0))
    eye1.setFillColor("black")
    eye1.setBorderColor("black")

    eye2 = Circle(2, Point(50,0))
    eye2.setFillColor("black")
    eye2.setBorderColor("black")

    leg1 = Rectangle(8, 20, Point(-15, 20))
    leg1.setFillColor('gray')
    leg1.setBorderColor('gray')

    leg2 = Rectangle(8, 20, Point(15, 20))
    leg2.setFillColor('gray')
    leg2.setBorderColor('gray')

    animal.add(body)
    animal.add(head)
    animal.add(eye1)
    animal.add(eye2)
    animal.add(leg1)
    animal.add(leg2)
    
    return animal

def makeCloud():
    """
    Creates a simple cloud shape with overlapping circles.
    
    Returns:
        Layer: A Layer representing a cloud.
    """
    cloud = Layer()
    
    c1 = Circle(20, Point(0,0))
    c1.setFillColor('white')
    c1.setBorderColor('white')
    
    c2 = Circle(25, Point(20,0))
    c2.setFillColor('white')
    c2.setBorderColor('white')
    
    c3 = Circle(15, Point(-20, 0))
    c3.setFillColor('white')
    c3.setBorderColor('white')
    
    cloud.add(c1)
    cloud.add(c2)
    cloud.add(c3)
    
    return cloud

canvas = Canvas(800, 600, 'skyBlue', 
                    'MP5 Animation')

grass = makeGrass()
canvas.add(grass)

tree = makeTree()
tree.moveTo(150, 400)  
canvas.add(tree)

animal1 = makeAnimal()
animal1.moveTo(350, 500)
canvas.add(animal1)

cloud = makeCloud()
cloud.moveTo(100, 100)
canvas.add(cloud)

cloud2 = cloud.clone()
canvas.add(cloud2)
cloud2.moveTo(200,175)

cloud3 = cloud.clone()
canvas.add(cloud3)
cloud3.moveTo(400,140)  

cloud4 = cloud.clone()
canvas.add(cloud4)
cloud4.moveTo(600,100)

cloud5 = cloud.clone()
canvas.add(cloud5)
cloud5.moveTo(-100,120)   

cloud6 = cloud.clone()
canvas.add(cloud6)
cloud6.moveTo (-200, 175)

cloud7 = cloud.clone()
canvas.add(cloud7)
cloud7.moveTo (-300, 100)

cloud8 = cloud.clone()
canvas.add(cloud8)
cloud8.moveTo (-400, 200)

animal2 = animal1.clone()
canvas.add(animal2)
animal2.moveTo(900, 500)

sleep(0.1)

for i in range(100):
    cloud.move(5, 1)
    cloud2.move(5, -1)
    cloud3.move(5, 1)
    cloud4.move(5, -0.5)
    cloud5.move(5, 1)
    cloud6.move(5, -0.5)
    cloud7.move(5, 0.75)
    cloud8.move(5, -0.6)

    tree.move(2, 0)
    sleep(0.1)
    tree.move(-2, 0)

    animal1.move(-10, 0)
    animal2.move(-4.5, -0.1)