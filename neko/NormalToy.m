//
//  NormalToy.m
//  neko
//
//  Created by Ethan Miller on 4/16/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "NormalToy.h"

@implementation NormalToy
-(id) initWithName:(NSString *)name andImage:(NSString *)img{
    self = [super initWithImageNamed:img];
    self.name = name;
    return self;
}
@end
