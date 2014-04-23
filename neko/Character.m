//
//  Character.m
//  neko
//
//  Created by Ethan Miller on 3/30/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Character.h"
#import "collisionTypes.h"
#import <math.h>
#import <stdlib.h>

#define M_PI_8 M_PI_4/2

@implementation Character

-(id) initWithName:(NSString *)name {
    self = [super initWithImageNamed:@"mati1.png"];
    //self.animationFrames = [[NSMutableArray alloc] init];
    self.name = name;
    self.velocity = 200;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.categoryBitMask = ColliderTypeNeko;
    self.physicsBody.collisionBitMask = ColliderTypeWall | ColliderTypeTrap | ColliderTypeExit | ColliderTypeToy;
    self.physicsBody.dynamic = YES;
    self.physicsBody.contactTestBitMask = ColliderTypeToy | ColliderTypeWall;
    return self;
}

-(id) init {
    return [self initWithName:@"neko"];
}

-(NSArray *)getAnimationFramesForBehavior:(BehaviorType)behavior direction:(DirectionType)dir {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *animation;
    NSString *prefix;
    switch (behavior) {
        case BehaviorSleep:
            animation = [SKTextureAtlas atlasNamed:@"sleep"];
            prefix = @"sleep";
            break;
        case BehaviorWalk:
            if (dir & DirectionRight) {
                if (dir & DirectionUp) {
                    animation = [SKTextureAtlas atlasNamed:@"walkUpRight"];
                    prefix = @"upright";
                } else if (dir & DirectionDown) {
                    animation = [SKTextureAtlas atlasNamed:@"walkDownRight"];
                    prefix = @"dwright";
                } else {
                    animation = [SKTextureAtlas atlasNamed:@"walkRight"];
                    prefix = @"right";
                }
            } else if (dir & DirectionLeft) {
                if (dir & DirectionUp) {
                    animation = [SKTextureAtlas atlasNamed:@"walkUpLeft"];
                    prefix = @"upleft";
                } else if (dir & DirectionDown) {
                    animation = [SKTextureAtlas atlasNamed:@"walkDownLeft"];
                    prefix = @"dwleft";
                } else {
                    animation = [SKTextureAtlas atlasNamed:@"walkLeft"];
                    prefix = @"left";
                }
            } else if (dir & DirectionUp) {
                animation = [SKTextureAtlas atlasNamed:@"walkUp"];
                prefix = @"up";
            } else {
                animation = [SKTextureAtlas atlasNamed:@"walkDown"];
                prefix = @"down";
            }
            break;
        case BehaviorGroom:
            animation = [SKTextureAtlas atlasNamed:@"groom"];
            prefix = @"jare";
            break;
        case BehaviorYawn:
            animation = [SKTextureAtlas atlasNamed:@"yawn"];
            prefix = @"mati";
            break;
        case BehaviorScratch:
            animation = [SKTextureAtlas atlasNamed:@"scratch"];
            prefix = @"kaki";
            break;
        default:
            NSLog(@"Moron. Forgot to implement behavior %d", behavior);
            return nil;
    }
    NSUInteger numFrames = animation.textureNames.count;
    //NSLog(@"Number of frames: %d", numFrames);
    for (int i = 0; i < numFrames; ++i) {
        NSString *textureName = [NSString stringWithFormat:@"%@%d", prefix, i+1];
        //NSLog(@"Added texture %@", textureName);
        [frames addObject:[animation textureNamed:textureName]];
    }
    return frames;
}

-(void) fallAsleep {
    [self runAction:[SKAction setTexture:[SKTexture textureWithImageNamed:@"mati1.png"]]];
    SKAction *yawn = [SKAction animateWithTextures:[self getAnimationFramesForBehavior:BehaviorYawn direction:DirectionStop]
                                      timePerFrame:1.0f
                                            resize:NO
                                           restore:YES];
    
    SKAction *sleep = [SKAction repeatActionForever:
                       [SKAction animateWithTextures:
                        [self getAnimationFramesForBehavior:BehaviorSleep
                                                  direction:DirectionStop]
                                        timePerFrame:0.3f
                                              resize:NO
                                             restore:YES]];
    int groomAction = arc4random_uniform(3);
    SKAction *groom;
    if (groomAction == 0) {
        groom = [SKAction repeatAction:
                 [SKAction animateWithTextures:
                  [self getAnimationFramesForBehavior:BehaviorGroom
                                            direction:DirectionStop]
                                  timePerFrame:0.2f
                                        resize:NO
                                       restore:YES]
                                 count:3];
    } else if (groomAction == 1) {
        groom = [SKAction repeatAction:
                 [SKAction animateWithTextures:
                  [self getAnimationFramesForBehavior:BehaviorScratch direction:DirectionStop]
                                  timePerFrame:0.5f
                                        resize:NO
                                       restore:YES]
                                 count:4];
    } else {
        [self removeAllActions];
        SKAction *setTexture = [SKAction setTexture:[SKTexture textureWithImageNamed:@"mati1.png"]
                                             resize:NO];
        SKAction *delay = [SKAction waitForDuration:1.0f];
        groom = [SKAction sequence:@[setTexture, delay]];
    }
    SKAction *seq = [SKAction sequence:@[groom, yawn, sleep]];
    
    [self runAction:seq];
}

-(void) moveToPoint:(CGPoint) pt {
    [self removeAllActions];
    DirectionType dir = [self directionToPoint:pt];
    CGFloat time = [self timeToPoint:pt];
    SKAction *delay = [SKAction waitForDuration:0.5f];
    SKAction *wakeUp = [SKAction setTexture:[SKTexture textureWithImageNamed:@"awake.png"]
                               resize:NO];
    
    SKAction *runAnimation = [SKAction repeatActionForever:
                              [SKAction animateWithTextures:[self getAnimationFramesForBehavior:BehaviorWalk direction:dir]
                                               timePerFrame:0.2f
                                                     resize:NO
                                                    restore:YES]];
    SKAction *move = [SKAction moveTo:pt duration:time];
    SKAction *ms = [SKAction sequence:@[wakeUp, delay]];
    //SKAction *mg = [SKAction group:@[move, runAnimation]];
    [self runAction:ms
         completion:^{
             [self runAction:runAnimation];
             [self runAction:move completion:^{
                 [self fallAsleep];
             }];
         }];
}

-(CGFloat)timeToPoint:(CGPoint)loc {
    if (!CGPointEqualToPoint(self.position, loc)) {
        return sqrt(pow(loc.x - self.position.x, 2) + pow(loc.y - self.position.y, 2))/self.velocity;
    }
    return 0;
}

-(DirectionType)directionToPoint:(CGPoint)loc {
    double dx = loc.x - self.position.x;
    double dy = loc.y - self.position.y;
    double theta = 0;
    DirectionType dir = DirectionStop;
    
    if (dx == 0) {
        // No! Bad math! No division by zero!
        if (dy > 0) {
            theta = M_PI_2;
        } else if (dy < 0) {
            theta = 3 * M_PI_2;
        } else {
            NSLog(@"moveToPoint: dx: %f dy:%f", dx, dy);
            return DirectionStop;
        }
    } else {
        theta = atan2(dy, dx);
    }
    //NSLog(@"theta: %f", theta);
    
    if (theta > -M_PI_8 && theta <= M_PI_8) {
        dir = DirectionRight;
    } else if (theta > M_PI_8 && theta <= 3*M_PI_8) {
        dir = DirectionUp|DirectionRight;
    } else if (theta > 3*M_PI_4/2 && theta <= 5*M_PI_8) {
        dir = DirectionUp;
    } else if (theta > 5*M_PI_8 && theta <= 7*M_PI_8) {
        dir = DirectionUp|DirectionLeft;
    } else if ((theta > 7*M_PI_8 && theta <= M_PI) || (theta < -7*M_PI_8)) {
        dir = DirectionLeft;
    } else if (theta > -7*M_PI_8 && theta <= -5*M_PI_8) {
        dir = DirectionDown|DirectionLeft;
    } else if (theta > -5*M_PI_8 && theta <= -3*M_PI_8) {
        dir = DirectionDown;
    } else if (theta > -3*M_PI_8 && theta <= -M_PI_8) {
        dir = DirectionDown|DirectionRight;
    } else {
        NSLog(@"Why am I here? (%f, %f)", dx, dy);
        assert(NO);
        dir = DirectionStop;
    }
    return dir;
}

@end
