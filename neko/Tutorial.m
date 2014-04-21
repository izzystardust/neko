//
//  Tutorial.m
//  neko
//
//  Created by Ethan Miller on 4/21/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Tutorial.h"

@implementation Tutorial


-(void)addButtonAtPoint:(CGPoint)pt withText:(NSString *)text andName:(NSString *)name {
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0.0
                                                                           alpha:1.0]
                                                    size:CGSizeMake(250, 70)];
    
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
@end
