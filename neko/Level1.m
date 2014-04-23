//
//  Level1.m
//  neko
//
//  Created by Ethan Miller on 4/21/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Level1.h"
#import "NormalToy.h"
#import "collisionTypes.h"

@implementation Level1
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        Character *neko = [[Character alloc] init];
        neko.position = CGPointMake(935, 100);
        neko.zPosition = 100;
        [neko runAction:[SKAction repeatActionForever:
                         [SKAction animateWithTextures:[neko getAnimationFramesForBehavior:BehaviorSleep direction:DirectionStop]
                                          timePerFrame:0.5f
                                                resize:NO
                                               restore:YES]]];
        
        [self addChild:neko];
        SKSpriteNode *wall = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
                                                          size:CGSizeMake(500, 400)];
        wall.name = @"wall";
        wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
        wall.physicsBody.dynamic = NO;
        wall.physicsBody.categoryBitMask = ColliderTypeWall;
        
        wall.position = CGPointMake(CGRectGetMaxX(self.frame)-550, CGRectGetMaxY(self.frame)-550);
        
        NormalToy *toy = [[NormalToy alloc] initWithImageNamed:@"mouse.png"];
        toy.position = CGPointMake(900, 300);
        toy.name = @"toy";
        toy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:toy.size];
        toy.physicsBody.dynamic = NO;
        toy.physicsBody.categoryBitMask = ColliderTypeToy;
        [self addChild:toy];
        [self.toys addObject:toy];
        
        NormalToy *toy2 = [[NormalToy alloc] initWithImageNamed:@"ball.png"];
        toy2.position = CGPointMake(1000, 550);
        toy2.name = @"toy2";
        [self addChild:toy2];
        [self.toys addObject:toy2];
        
        SKSpriteNode *exit = [SKSpriteNode spriteNodeWithImageNamed:@"exit.png"];
        exit.position = CGPointMake(50, 700);
        exit.name = @"exit";
        exit.zPosition = 5;
        exit.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:exit.size];
        exit.physicsBody.dynamic = NO;
        exit.physicsBody.categoryBitMask = ColliderTypeExit;
        [self addChild:exit];
        
        [self addChild:wall];
    }
    return self;
}
@end
