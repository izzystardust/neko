//
//  Toy2.h
//  neko
//
//  Created by Ethan Miller on 4/16/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Toy <NSObject>
-(id) initWithName:(NSString *)name andImage:(NSString *)img;
@property BOOL createsSound;
@property BOOL interestingIfSeen;
@end
