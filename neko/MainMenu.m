//
//  MainMenu.m
//  neko
//
//  Created by Ethan Miller on 3/30/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Sniglet-Regular"];
        title.text = @"neko";
        title.fontSize = 200;
        title.fontColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        title.position = CGPointMake(400, 600);
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        
        [self addChild:title];
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

@end
