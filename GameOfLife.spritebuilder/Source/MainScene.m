//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"

@implementation MainScene {
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
    
}


    // CCTimer is a custom class
- (id)init {
    self = [super init];
    if (self) {
        _timer = [[CCTimer alloc]init];
    }
    return self;
    //this is a custom class initialiser which by convention you check if the super initialiser returns a nil first - it basically some standard code you should always use
    
    
}



- (void)play {
    // this tells the game to call a method  called step evert half second
    [self schedule:@selector(step) interval:0.5f];
    
}

-(void)pause {
    [self unschedule:@selector(step)];
}


    // this method gets called every half second when you hit the play button and stop on the pause button
-(void)step {
    
    [_grid evolveStep];
    _generationLabel.string = [NSString stringWithFormat:@"%d", _grid.generation];
    _populationLabel.string = [NSString stringWithFormat:@"%d", _grid.totalAlive];
    

}
@end
