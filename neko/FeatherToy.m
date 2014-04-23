//
//  FeatherToy.m
//  neko
//
//  Created by Ethan Miller on 4/23/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "FeatherToy.h"
#import "collisionTypes.h"

@implementation FeatherToy
- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        self.makesSoundWhenTapped = NO;
        self.distractsWhenSeen = YES;
        self.removeOnCollision = YES;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        self.physicsBody.categoryBitMask = ColliderTypeToy;
        
    }
    
    return self;
}
@end
