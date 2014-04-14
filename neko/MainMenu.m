//
//  MainMenu.m
//  neko
//
//  Created by Ethan Miller on 3/30/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "MainMenu.h"
#import "Level.h"

@implementation MainMenu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Sniglet-Regular"];
        title.text = @"Neko";
        title.fontSize = 200;
        title.fontColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        title.position = CGPointMake(300, 600);
        [self addChild:title];
        
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        
        [self addButtonAtPoint:CGPointMake(700, 500) withText:@"Play!" andName:@"play"];
        [self addButtonAtPoint:CGPointMake(700, 400) withText:@"Credits" andName:@"cred"];
    } else {
        NSLog(@"WTF?!");
    }
    return self;
}

-(void)addButtonAtPoint:(CGPoint)pt withText:(NSString *)text andName:(NSString *)name {
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0.0
                                                                           alpha:1.0]
                                                    size:CGSizeMake(175, 70)];

    bg.position = pt;
    bg.name = name;
    [self addChild:bg];
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Sniglet-Regular"];
    label.text = text;
    label.fontSize = 40;
    label.fontColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    label.position = CGPointMake(pt.x, pt.y-12);
    [self addChild:label];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    SKNode *playButton = [self childNodeWithName:@"play"];
    SKNode *credButton = [self childNodeWithName:@"cred"];
    for (UITouch *touch in touches) {
        CGPoint loc = [touch locationInNode:self];
        if(CGRectContainsPoint([playButton frame], loc)) {
            SKTransition *transition = [SKTransition doorwayWithDuration:0.5];
            Level *l = [[Level alloc] initWithSize:CGSizeMake(1024, 768)];
            [self.scene.view presentScene:l transition:transition];
        } else if (CGRectContainsPoint([credButton frame], loc)) {
            UIAlertView *credits = [[UIAlertView alloc] initWithTitle:@"Credits"
                                                              message:@"neko written by Ethan Miller\nneko character and animations public domain\n"
                                                             delegate:nil
                                                    cancelButtonTitle:@"Ok"
                                                    otherButtonTitles:nil];
            [credits show];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
