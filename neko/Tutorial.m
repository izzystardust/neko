//
//  Tutorial.m
//  neko
//
//  Created by Ethan Miller on 4/21/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "Tutorial.h"
#import "Character.h"

@implementation Tutorial

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Sniglet-Regular"];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        title.text = @"neko";
        title.fontSize = 200;
        title.fontColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        title.position = CGPointMake(300, 600);
        [self addChild:title];
        
        Character *neko = [[Character alloc] initWithName:@"neko"];
        neko.position = CGPointMake(240, 719);
        [neko runAction:[SKAction repeatActionForever:
                         [SKAction animateWithTextures:[neko getAnimationFramesForBehavior:BehaviorSleep direction:DirectionStop]
                                          timePerFrame:1.0f
                                                resize:NO
                                               restore:YES]]];
        neko.zPosition = 100;
        [self addChild:neko];
        
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        
        SKLabelNode *inst = [SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
        inst.text = @"zzzzzzzzz...\nThis will be implemented eventually.";
        inst.fontSize = 32;
        inst.position = CGPointMake(300, 400);
        inst.fontColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        [self addChild:inst];
        _lines = @[@"Oh! Hi!", @"Are you here to help me?"];
        [self addButtonAtPoint:CGPointMake(900, 100) withText:@"continue" andName:@"next"];
        
    } else {
        NSLog(@"WTF?!");
    }
    return self;
}

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
