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
        
        SKSpriteNode *neko = [SKSpriteNode spriteNodeWithImageNamed:@"mati2.xbm"];
        neko.name = @"neko";
        neko.position = CGPointMake(623, 250);
        neko.zPosition = 100;
        neko.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:neko.size];
        neko.physicsBody.categoryBitMask = ColliderTypeNeko;
        neko.physicsBody.collisionBitMask = ColliderTypeWall | ColliderTypeTrap | ColliderTypeExit;
        neko.physicsBody.contactTestBitMask = neko.physicsBody.collisionBitMask;
        neko.physicsBody.dynamic = NO;
        [self addChild:neko];
        
        SKSpriteNode *wall = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
                                                          size:CGSizeMake(500, 400)];
        wall.name = @"wall";
        wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
        wall.physicsBody.dynamic = NO;
        wall.physicsBody.categoryBitMask = ColliderTypeWall;
        wall.physicsBody.contactTestBitMask = ColliderTypeNeko;
        wall.position = CGPointMake(CGRectGetMaxX(self.frame)-550, CGRectGetMaxY(self.frame)-550);
        
        SKSpriteNode *toy = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]
                                                         size:CGSizeMake(20, 20)];
        toy.position = CGPointMake(660, 750);
        toy.name = @"toy";
        toy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:toy.size];
        toy.physicsBody.dynamic = NO;
        toy.physicsBody.categoryBitMask = ColliderTypeExit;
        toy.physicsBody.contactTestBitMask = ColliderTypeNeko;
        [self addChild:toy];
        
        SKSpriteNode *toy2 = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]
                                                          size:CGSizeMake(20, 20)];
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
    SKNode *neko = [self childNodeWithName:@"neko"];
    SKNode *toy = [self childNodeWithName:@"toy"];
    SKNode *toy2 = [self childNodeWithName:@"toy2"];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"Touch at %f, %f", location.x, location.y);
        if (CGRectContainsPoint([toy frame], location)) {
            SKAction *gotoToy = [SKAction moveTo:toy.frame.origin duration:1];
            [neko runAction:gotoToy];
        }
        if (CGRectContainsPoint([toy2 frame], location)) {
            SKAction *gotoToy = [SKAction moveTo:toy2.frame.origin duration:1];
            [neko runAction:gotoToy];
        }
        //SKAction *action = [SKAction moveTo:location duration:1];
        //[neko runAction:action];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (self.start == 0) {
        self.start = currentTime;
    }
    NSLog(@"start, current: %f, %f", self.start, currentTime);
    if (currentTime > self.start + .1) {
        self.shouldWin = YES;
        [self isExitVisibleToNeko];
        if (self.shouldWin == YES) {
            SKNode *exit = [self childNodeWithName:@"exit"];
            SKAction *gotoexit = [SKAction moveTo:CGPointMake(exit.position.x+1, exit.position.y+1) duration:1];
            [[self childNodeWithName:@"neko"] runAction:gotoexit];
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
