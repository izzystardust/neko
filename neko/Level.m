//
//  MyScene.m
//  neko
//
//  Created by Ethan Miller on 3/3/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Level.h"
#import "Character.h"

@implementation Level

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        self.start = 0;
        self.hasWon = NO;

        Character *neko = [[Character alloc] init];
        neko.position = CGPointMake(623, 250);
        neko.zPosition = 100;
        [neko runAction:[SKAction repeatActionForever:
                         [SKAction animateWithTextures:[neko getAnimationFramesForBehavior:BehaviorSleep direction:DirectionStop]
                                          timePerFrame:0.5f
                                                resize:NO
                                               restore:YES]]];
        
        [self addChild:neko];
        //NSLog(@"Aniframes: %@", neko.animationFrames);
        SKSpriteNode *wall = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
                                                          size:CGSizeMake(500, 400)];
        wall.name = @"wall";
        wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
        wall.physicsBody.dynamic = NO;
        wall.physicsBody.categoryBitMask = ColliderTypeWall;
        wall.physicsBody.contactTestBitMask = ColliderTypeNeko;
        wall.position = CGPointMake(CGRectGetMaxX(self.frame)-550, CGRectGetMaxY(self.frame)-550);
        
        SKSpriteNode *toy = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]
                                                         size:CGSizeMake(40, 40)];
        toy.position = CGPointMake(660, 750);
        toy.name = @"toy";
        toy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:toy.size];
        toy.physicsBody.dynamic = NO;
        toy.physicsBody.categoryBitMask = ColliderTypeExit;
        toy.physicsBody.contactTestBitMask = ColliderTypeNeko;
        [self addChild:toy];
        
        SKSpriteNode *toy2 = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]
                                                          size:CGSizeMake(40, 40)];
        toy2.position = CGPointMake(660, 500);
        toy2.name = @"toy2";
        [self addChild:toy2];
        
        SKSpriteNode *exit = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0]
                                                          size:CGSizeMake(50, 80)];
        exit.position = CGPointMake(25, 764);
        exit.name = @"exit";
        exit.zPosition = 5;
        [self addChild:exit];

        NSLog(@"Setting up gravity\n");
//        self.physicsWorld.gravity = CGVectorMake(0, 0);
        //self.physicsWorld.contactDelegate = self;
        
        [self addChild:wall];
    }
    return self;
}

-(BOOL)isExitVisibleToNeko {
    CGPoint rayStart = [self childNodeWithName:@"neko"].position;
    CGPoint rayEnd = [self childNodeWithName:@"exit"].position;
    //int i = 0;
    [self.physicsWorld enumerateBodiesAlongRayStart:rayStart end:rayEnd usingBlock:^(SKPhysicsBody *body, CGPoint point, CGVector normal, BOOL *stop) {
        self.shouldWin = NO;
    }];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    Character *neko = (Character *)[self childNodeWithName:@"neko"];
    SKNode *toy = [self childNodeWithName:@"toy"];
    SKNode *toy2 = [self childNodeWithName:@"toy2"];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"Touch at %f, %f", location.x, location.y);
//        [neko runAction:[SKAction moveTo:location duration:1]];
        if (CGRectContainsPoint([toy frame], location) || CGRectContainsPoint([toy2 frame], location)) {
            [neko moveToPoint:location];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (!self.hasWon) {
        if (self.start == 0) {
            self.start = currentTime;
        }
        if (currentTime > self.start + .1) {
            self.shouldWin = YES;
            [self isExitVisibleToNeko];
            if (self.shouldWin == YES) {
                SKNode *exit = [self childNodeWithName:@"exit"];
                [(Character *)[self childNodeWithName:@"neko"] moveToPoint:CGPointMake(exit.position.x+1, exit.position.y+1)];
                self.hasWon = YES;
            }
        }
    }
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"Shit collided, yo");
    SKNode *node = contact.bodyA.node;
    if ([node.name isEqualToString:@"neko"]) {
        [node removeAllActions];
    }
}

-(void)didEndContact:(SKPhysicsContact *)contact {
    
}



@end
