//
//  Grid.m
//  GameOfLife
//
//  Created by andrew on 26/06/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

// these are variables that cannot be changed
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

- (void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    // accept touches on the grid
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    // divide the grid's size by the number of columns/rows to figure out the right width and height of each cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    // initialize the array as a blank NSMutableArray
    _gridArray = [NSMutableArray array];
    
    // initialize Creatures
    for (int i = 0; i < GRID_ROWS; i++) {
        // this is how you create two dimensional arrays in Objective-C. You put arrays into arrays.
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            
            // this is shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            // make creatures visible to test this method, remove this once we know we have filled the grid properly
            //creature.isAlive = YES;
            
            x+=_cellWidth;
        }
        
        y += _cellHeight;
        NSLog(@" row  %f column  ", _cellWidth);
        NSLog(@" row  %f "      ,  _cellHeight);
    }
}


-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self ];
    
    
    //get the Creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    
    //Invert its state - kill it if its alive, bring it to life if it's dead.
    creature.isAlive = !creature.isAlive;
}

-(Creature *)creatureForTouchPosition:(CGPoint)touchPosition {
    // get the row and the column that was touched, return the Creature inside the corresponding cell
    //int row = 0;
    //int column = 0;
    
    int row = touchPosition.y / _cellHeight;
    int column = touchPosition.x / _cellWidth;

    return _gridArray[row][column];
    
}

-(void)evolveStep {
    //update each Creatures neighbour count
    [self countNeighbors];
    
    //update each Creatures State
    [self updateCreatures];
    
    
    //update the generation so the label's text will display the correct generation
    _generation++;
    
}

-(void)countNeighbors {
    //iterate through the rows
    //note that the NSArray has a method 'count'that will return the number of elements in the Array
    for (int i = 0; i < [_gridArray[i] count]; i++) {

    for (int j = 0; j < [_gridArray[i] count]; j++) {
        //access the creature in the cell that corresponds to the current row / column
        Creature *currentCreature = _gridArray[i][j];
        
        //every creature has a living neighbour's property that was created earlier
        currentCreature.livingNeighbors = 0;
        
        //now examine every cell arround the current one
        //go through the row on top of the current cell, the row the cell is in and the row past the current cell
        for (int x = (i-1); x <= (x+1); x++) {
            //go through the column to the left of the current cell the column cell is in and the column to the right of the current cell
            for (int y = (j-1); y <= (j+1); y++) {
                //check that the cell we are checking isn't off the screen
                BOOL isIndexValid;
                isIndexValid = [self isIndexValidForX:x andY:y];
                // skip over all the cells that are off screen and the cell that contains the creature we are curently updating
                if (!((x == i ) && (y == j )) && isIndexValid ) {
                    Creature *neighbor = _gridArray[x][y];
                    if (neighbor.isAlive) {
                        currentCreature.livingNeighbors +=1;
                    }
                }
            }
        }
    }
        
}
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y {
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS) {
        isIndexValid = NO;
    }
    return isIndexValid;
}

    
    -(void)UpdateCreatures {
    
}

@end