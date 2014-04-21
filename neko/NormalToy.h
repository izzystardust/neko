//
//  NormalToy.h
//  neko
//
//  Created by Ethan Miller on 4/16/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Toy.h"
#import <SpriteKit/SpriteKit.h>

@interface NormalToy : SKSpriteNode <Toy>
@property BOOL createsSound;
@property BOOL interestingIfSeen;
@end
