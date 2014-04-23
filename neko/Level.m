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
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        self.toys = [[NSMutableSet alloc] init];
        self.backgroundColor = [SKColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        self.start = 0;
        self.hasWon = NO;
    }
    return self;
}

-(BOOL)isExitVisibleToNeko {
    CGPoint rayStart = [self childNodeWithName:@"neko"].position;
    CGPoint rayEnd = [self childNodeWithName:@"exit"].position;
    SKNode *exit = [self childNodeWithName:@"exit"];
    [self.physicsWorld enumerateBodiesAlongRayStart:rayStart end:rayEnd usingBlock:^(SKPhysicsBody *body, CGPoint point, CGVector normal, BOOL *stop) {
        if (body != exit.physicsBody) {
            self.canSeeExit = NO;
        }
    }];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    Character *neko = (Character *)[self childNodeWithName:@"neko"];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"Touch at %f, %f", location.x, location.y);
        for (Toy *toy in self.toys) {
            if (toy.makesSoundWhenTapped && CGRectContainsPoint([toy frame], location)) {
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
            self.canSeeExit = YES;
            [self isExitVisibleToNeko];
            if (self.canSeeExit == YES) {
                SKNode *exit = [self childNodeWithName:@"exit"];
                [(Character *)[self childNodeWithName:@"neko"] moveToPoint:CGPointMake(exit.position.x+1, exit.position.y+1)];
                self.hasWon = YES;
            }
        }
    }
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"Bodies collided: %@ and %@", contact.bodyA.node.name,
          contact.bodyB.node.name);
    SKNode *a = contact.bodyB.node;
    SKNode *b = contact.bodyA.node;
    if ([a.name isEqualToString:@"neko"]) {
        if ([b.name isEqualToString:@"wall"]) {
            //[a removeAllActions];
        }
        if ([b.name isEqualToString:@"exit"]) {
            UIAlertView *yay = [[UIAlertView alloc]
                                initWithTitle:@"Level defeated!"
                                message:@"You took time (TODO - keep track of time"
                                delegate:self
                                cancelButtonTitle:@"Main Menu"
                                otherButtonTitles:@"Continue", nil];
            [yay show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"Dialog dismissed with button %i", buttonIndex);
}

//- (void) addWall:(NSValue *)point, ... {
//    int s = 4; int i = 0;
//    CGPoint *pts = malloc(s*sizeof(CGPoint));
//    va_list args;
//    va_start(args, point);
//    for (NSValue *pt = point; pt != nil; pt = va_arg(args, NSValue *)) {
//        if (i >= s) {
//            pts = realloc(pts, s = 2*s);
//        }
//        pts[i] = [pt CGPointValue];
//        ++i;
//    }
//    
//    va_end(args);
//    CGMutablePathRef wallPath = NULL;
//    CGPathAddLines(wallPath, NULL, pts, i);
//    SKShapeNode *wall;
//    free(pts);
//}

@end
