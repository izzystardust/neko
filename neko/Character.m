//
//  Character.m
//  neko
//
//  Created by Ethan Miller on 3/30/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Character.h"

@implementation Character

-(void)getAnimationFramesForBehavior:(BehaviorType)behavior {
    SKTextureAtlas *animation;
    NSString *prefix;
    switch (behavior) {
        case BehaviorSleep:
            animation = [SKTextureAtlas atlasNamed:@"sleepImages"];
            prefix = @"sleep";
            break;
        case BehaviorWalkRight:
            animation = [SKTextureAtlas atlasNamed:@"walkRightImages"];
            prefix = @"right";
            break;
        case BehaviorWalkUpRight:
            animation = [SKTextureAtlas atlasNamed:@"walkUpRightImages"];
            prefix = @"upright";
            break;
        case BehaviorWalkUp:
            animation = [SKTextureAtlas atlasNamed:@"walkUpImages"];
            prefix = @"up";
            break;
        case BehaviorWalkUpLeft:
            animation = [SKTextureAtlas atlasNamed:@"walkUpLeftImages"];
            prefix = @"upleft";
            break;
        case BehaviorWalkLeft:
            animation = [SKTextureAtlas atlasNamed:@"walkLeftImages"];
            prefix = @"left";
            break;
        case BehaviorWalkDownLeft:
            animation = [SKTextureAtlas atlasNamed:@"walkDownLeftImages"];
            prefix = @"dwleft";
            break;
        case BehaviorWalkDown:
            animation = [SKTextureAtlas atlasNamed:@"walkDownImages"];
            prefix = @"down";
            break;
        case BehaviorWalkDownRight:
            animation = [SKTextureAtlas atlasNamed:@"walkDownRightImages"];
            prefix = @"dwright";
            break;
        case BehaviorScratch:
            animation = [SKTextureAtlas atlasNamed:@"scratchingImages"];
            prefix = @"kaki";
            break;
        default:
            NSLog(@"Moron. Forgot to implement behavior %d", behavior);
            return;
    }
    int numFrames = animation.textureNames.count;
    [self.animationFrames removeAllObjects];
    for (int i = 0; i < numFrames; ++i) {
        NSString *textureName = [NSString stringWithFormat:@"%@%d", prefix, i];
        [self.animationFrames addObject:[animation textureNamed:textureName]];
    }
}

@end
