//
//  MyScene.m
//  neko
//
//  Created by Ethan Miller on 3/3/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Level1.h"
#import "Character.h"

@implementation Level1

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        
        SKSpriteNode *neko = [SKSpriteNode spriteNodeWithImageNamed:@"mati2.xbm"];
        neko.name = @"neko";
        neko.position = CGPointMake(623, 250);
        [self addChild:neko];
        
        SKSpriteNode *wall = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
                                                          size:CGSizeMake(500, 500)];
        neko.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:neko.size];
        neko.physicsBody.categoryBitMask = ColliderTypeNeko;
        neko.physicsBody.collisionBitMask = ColliderTypeWall | ColliderTypeTrap | ColliderTypeExit;
        neko.physicsBody.dynamic = NO;
        
        wall.name = @"wall";
        wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
        wall.physicsBody.dynamic = NO;
        wall.physicsBody.categoryBitMask = ColliderTypeWall;
        wall.position = CGPointMake(CGRectGetMaxX(self.frame)-550, CGRectGetMaxY(self.frame)-550);
        [self addChild:wall];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    SKNode *neko = [self childNodeWithName:@"neko"];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];

        SKAction *action = [SKAction moveTo:location duration:1];
        [neko runAction:action];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"Shit collided, yo");
    SKNode *node = contact.bodyA.node;
    if ([node.name isEqualToString:@"neko"]) {
        SKAction *stop = [SKAction moveBy:CGVectorMake(0, 0) duration:0];
        [node runAction:stop];
    }
}



@end
