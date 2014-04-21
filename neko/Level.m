//
//  MyScene.m
//  neko
//
//  Created by Ethan Miller on 3/3/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Level.h"
#import "Character.h"
#import "Toy.h"

@implementation Level
- (id) initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.toys = [[NSMutableSet alloc] init];
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
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"Touch at %f, %f", location.x, location.y);
        NSLog(@"Toys: %@", self.toys);
        for (Toy *toy in self.toys) {
            if (CGRectContainsPoint([toy frame], location)) {
                [neko moveToPoint:location];
                break;
            }
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
