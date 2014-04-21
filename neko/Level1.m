//
//  Level1.m
//  neko
//
//  Created by Ethan Miller on 4/21/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Level1.h"
#import "NormalToy.h"

@implementation Level1
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        self.start = 0;
        self.hasWon = NO;
        
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
        wall.physicsBody.contactTestBitMask = ColliderTypeNeko;
        wall.position = CGPointMake(CGRectGetMaxX(self.frame)-550, CGRectGetMaxY(self.frame)-550);
        
        NormalToy *toy = [NormalToy spriteNodeWithImageNamed:@"mouse.png"];
        toy.position = CGPointMake(900, 300);
        toy.name = @"toy";
        toy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:toy.size];
        toy.physicsBody.dynamic = NO;
        toy.physicsBody.categoryBitMask = ColliderTypeExit;
        toy.physicsBody.contactTestBitMask = ColliderTypeNeko;
        [self addChild:toy];
        [self.toys addObject:toy];
        
        NormalToy *toy2 = [NormalToy spriteNodeWithImageNamed:@"ball.png"];
        toy2.position = CGPointMake(1000, 550);
        toy2.name = @"toy2";
        [self addChild:toy2];
        [self.toys addObject:toy2];
        
        SKSpriteNode *exit = [SKSpriteNode spriteNodeWithImageNamed:@"exit.png"];
        exit.position = CGPointMake(50, 700);
        exit.name = @"exit";
        exit.zPosition = 5;
        [self addChild:exit];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        [self addChild:wall];
    }
    return self;
}
@end
