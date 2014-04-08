//
//  MyScene.h
//  neko
//

//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Character.h"

@interface Level : SKScene
@property BOOL shouldWin;
@property BOOL hasWon;
@property CFTimeInterval start;
@property Character *neko;
@end
