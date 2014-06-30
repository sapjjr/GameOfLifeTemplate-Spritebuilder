//
//  Grid.h
//  GameOfLife
//
//  Created by andrew on 26/06/2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

@property (nonatomic, assign) int totalAlive;
@property (nonatomic, assign) int generation;

//These are methods 
-(void) evolveStep;
-(void) countNeighbors;

//-(BOOL)isIndexValidForX:(int)x andY:(int)y;
-(BOOL)isIndexValidForX;
-(BOOL)isIndexValidForX:(int)x andY:(int)y;;
-(void)updateCreatures;

@end
