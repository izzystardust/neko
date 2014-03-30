//
//  Character.h
//  neko
//
//  Created by Ethan Miller on 3/30/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Character : SKSpriteNode

@end

typedef enum : uint8_t {
    ColliderTypeNeko = 1,
    ColliderTypeWall = 2,
    ColliderTypeToy = 4,
    ColliderTypeTrap = 8,
    ColliderTypeExit = 16
} ColliderType;