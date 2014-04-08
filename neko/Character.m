//
//  Character.m
//  neko
//
//  Created by Ethan Miller on 3/30/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Character.h"
#import <math.h>
#define M_PI_8 M_PI_4/2

@implementation Character

-(id) init {
    self = [super initWithImageNamed:@"mati1.png"];
    //self.animationFrames = [[NSMutableArray alloc] init];
    self.name = @"neko";
    self.velocity = 200;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.categoryBitMask = ColliderTypeNeko;
    self.physicsBody.collisionBitMask = ColliderTypeWall | ColliderTypeTrap | ColliderTypeExit;
    self.physicsBody.dynamic = NO;
    return self;
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
        default:
            NSLog(@"Moron. Forgot to implement behavior %d", behavior);
            return nil;
    }
    int numFrames = animation.textureNames.count;
    //NSLog(@"Number of frames: %d", numFrames);
    for (int i = 0; i < numFrames; ++i) {
        NSString *textureName = [NSString stringWithFormat:@"%@%d", prefix, i+1];
        //NSLog(@"Added texture %@", textureName);
        [frames addObject:[animation textureNamed:textureName]];
    }
    return frames;
}

-(void) fallAsleep {
    SKAction *yawn = [SKAction animateWithTextures:[self getAnimationFramesForBehavior:BehaviorYawn direction:DirectionStop]
                                      timePerFrame:1.0f
                                            resize:NO
                                           restore:YES];
    
    SKAction *sleep = [SKAction repeatActionForever:
                       [SKAction animateWithTextures:
                        [self getAnimationFramesForBehavior:BehaviorSleep
                                                  direction:DirectionStop]
                                        timePerFrame:0.5f
                                              resize:NO
                                             restore:YES]];
    
    SKAction *groom = [SKAction repeatAction:
                       [SKAction animateWithTextures:
                        [self getAnimationFramesForBehavior:BehaviorGroom
                                                  direction:DirectionStop]
                                        timePerFrame:0.2f
                                              resize:NO
                                             restore:YES]
                                       count:3];
    
    SKAction *todo = [SKAction sequence:@[groom, yawn, sleep]];
    
    [self runAction:todo];
}

-(void) moveToPoint:(CGPoint) pt {
    [self removeAllActions];
    DirectionType dir = [self directionToPoint:pt];
    CGFloat time = [self timeToPoint:pt];
    //self.animationFrames = [self getAnimationFramesForBehavior:BehaviorWalk direction:dir];
    //[self animateWithFrameTime:0.2f];
    [self runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:[self getAnimationFramesForBehavior:BehaviorWalk direction:dir]
                                      timePerFrame:0.2f
                                            resize:NO
                                           restore:YES]]];
    SKAction *move = [SKAction moveTo:pt duration:time];
    [self runAction:move
     completion:^{
         [self fallAsleep];
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
        NSLog(@"Why am I here?");
        assert(NO);
        dir = DirectionStop;
    }
    NSLog(@"dir: %d", dir);
    return dir;
}

@end
