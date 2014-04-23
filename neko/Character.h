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
    BehaviorSleep = 0,
    BehaviorWalk = 1,
    BehaviorGroom = 2,
    BehaviorYawn = 3,
    BehaviorWake = 4,
    BehaviorScratch = 5,
} BehaviorType;

typedef enum : uint8_t {
    DirectionStop = 0,
    DirectionRight = 1 << 0,
    DirectionUp = 1 << 1,
    DirectionLeft = 1 << 2,
    DirectionDown = 1 << 3,
} DirectionType;

@interface Character : SKSpriteNode
@property CGFloat velocity;

-(NSMutableArray *)getAnimationFramesForBehavior:(BehaviorType) behavior direction:(DirectionType)dir;
-(void)moveToPoint:(CGPoint) pt;
-(id) initWithName:(NSString *)name;
@end

