//
//  Level2.m
//  neko
//
//  Created by Ethan Miller on 4/28/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Level2.h"
#import "collisionTypes.h"
#import "NormalToy.h"
#import "FeatherToy.h"

@implementation Level2
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.infoText = @"Tap to place the feather\n\nThe feather doesn't make noise, but if Neko sees it, she'll run to it";
        Character *neko = [[Character alloc] init];
        neko.position = CGPointMake(935, 100);
        neko.zPosition = 100;
        [neko runAction:[SKAction repeatActionForever:
                         [SKAction animateWithTextures:[neko getAnimationFramesForBehavior:BehaviorSleep direction:DirectionStop]
                                          timePerFrame:0.5f
                                                resize:NO
                                               restore:YES]]];
        
        [self addChild:neko];
        
        SKSpriteNode *wall1 = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
                                                           size:CGSizeMake(500, 400)];
        
        NormalToy *mouse = [[NormalToy alloc] initWithImageNamed:@"mouse.png"];
        mouse.position = CGPointMake(935, 600);
        mouse.name = @"toy";
        [self addChild:mouse];
        [self.toys addObject:mouse];
        
        wall1.name = @"wall";
        wall1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall1.size];
        wall1.physicsBody.dynamic = NO;
        wall1.physicsBody.categoryBitMask = ColliderTypeWall;
        wall1.position = CGPointMake(512, 600);
        [self addChild:wall1];
        
        SKSpriteNode *wall2 = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithWhite:0 alpha:1] size:CGSizeMake(500, 200)];
        wall2.name = @"wall";
        wall2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall2.size];
        wall2.physicsBody.dynamic = NO;
        wall2.physicsBody.categoryBitMask = ColliderTypeWall;
        wall2.position = CGPointMake(512, 100);
        [self addChild:wall2];
        
        SKSpriteNode *exit = [SKSpriteNode spriteNodeWithImageNamed:@"exit.png"];
        exit.position = CGPointMake(50, 700);
        exit.name = @"exit";
        exit.zPosition = 5;
        exit.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:exit.size];
        exit.physicsBody.dynamic = NO;
        exit.physicsBody.categoryBitMask = ColliderTypeExit;
        [self addChild:exit];
        
        [self showInfoText];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.featherPlaced) {
        [super touchesBegan:touches withEvent:event];
    } else {
        for (UITouch *touch in touches) {
            FeatherToy *f = [[FeatherToy alloc] initWithImageNamed:@"feather.png"];
            f.position = [touch locationInNode:self];
            f.name = @"feather";
            [self addChild:f];
            [self.toys addObject:f];
            self.featherPlaced = YES;
        }
    }
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    if (!self.canSeeExit) {
        __block BOOL canSeeFeather = YES;
        SKNode *f = [self childNodeWithName:@"feather"];
        CGPoint start = [self childNodeWithName:@"neko"].position;
        CGPoint end = [self childNodeWithName:@"feather"].position;
        [self.physicsWorld enumerateBodiesAlongRayStart:start
                                                    end:end
                                             usingBlock:^(SKPhysicsBody *body, CGPoint point, CGVector normal, BOOL *stop) {
                                                 if (body != f.physicsBody) {
                                                     canSeeFeather = NO;
                                                 }
                                             }];
        if (canSeeFeather && !self.goingToFeather) {
            Character *neko = (Character *)[self childNodeWithName:@"neko"];
            [neko moveToPoint:end];
            self.goingToFeather = YES;
        }
    }
}


@end
