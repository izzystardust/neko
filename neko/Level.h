//
//  MyScene.h
//  neko
//

//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Character.h"

@interface Level : SKScene <SKPhysicsContactDelegate, UIAlertViewDelegate>
@property BOOL canSeeExit;
@property BOOL hasWon;
@property CFTimeInterval start;
@property Character *neko;
@property NSMutableSet *toys;

//-(void) addWall:(NSValue *)point, ... NS_REQUIRES_NIL_TERMINATION;

@end
