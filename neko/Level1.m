//
//  Level1.m
//  neko
//
//  Created by Ethan Miller on 4/21/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Level1.h"
#import "Level2.h"
#import "NormalToy.h"
#import "collisionTypes.h"

@implementation Level1
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.infoText = @"The mouse makes noise when tapped.";
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
        toy.position = CGPointMake(1000, 550);
        toy.name = @"toy";
        [self addChild:toy];
        [self.toys addObject:toy];
        
        SKSpriteNode *exit = [SKSpriteNode spriteNodeWithImageNamed:@"exit.png"];
        exit.position = CGPointMake(50, 700);
        exit.name = @"exit";
        exit.zPosition = 5;
        exit.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:exit.size];
        exit.physicsBody.dynamic = NO;
        exit.physicsBody.categoryBitMask = ColliderTypeExit;
        [self addChild:exit];
        
        [self addChild:wall];
        [self showInfoText];
    }
    return self;
}

- (void) gotoNextLevel {
    Level2 *l = [[Level2 alloc] initWithSize:CGSizeMake(1024, 768)];
    SKTransition *transition = [SKTransition doorwayWithDuration:0.5];
    transition.pausesIncomingScene = NO;
    transition.pausesOutgoingScene = NO;
    [self.scene.view presentScene:l transition:transition];
}
@end
