//
//  Character.h
//  neko
//
//  Created by Ethan Miller on 3/30/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

typedef enum : uint8_t {
    ColliderTypeNeko = 1,
    ColliderTypeWall = 2,
    ColliderTypeToy = 4,
    ColliderTypeTrap = 8,
    ColliderTypeExit = 16
} ColliderType;

typedef enum : uint8_t {
    BehaviorSleep = 0,
    BehaviorWalkRight = 1,
    BehaviorWalkUpRight = 2,
    BehaviorWalkUp = 3,
    BehaviorWalkUpLeft = 4,
    BehaviorWalkLeft = 5,
    BehaviorWalkDownLeft = 6,
    BehaviorWalkDown = 7,
    BehaviorWalkDownRight = 8,
    BehaviorScratch = 9
} BehaviorType;

@interface Character : SKSpriteNode
@property NSMutableArray *animationFrames;

-(void)getAnimationFramesForBehavior:(BehaviorType) behavior;
@end

