//
//  NormalToy.m
//  neko
//
//  Created by Ethan Miller on 4/21/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "NormalToy.h"
#import "collisionTypes.h"

@implementation NormalToy

- (id) initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        self.makesSoundWhenTapped = YES;
        self.distractsWhenSeen = NO;
        self.removeOnCollision = NO;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = ColliderTypeToy;
    }
    return self;
}

@end
