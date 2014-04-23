//
//  collisionTypes.h
//  neko
//
//  Created by Ethan Miller on 4/23/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#ifndef neko_collisionTypes_h
#define neko_collisionTypes_h

typedef enum : uint8_t {
    ColliderTypeNeko = 1,
    ColliderTypeWall = 2,
    ColliderTypeToy  = 4,
    ColliderTypeTrap = 8,
    ColliderTypeExit = 16
} ColliderType;

#endif
