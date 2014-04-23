//
//  MainMenu.m
//  neko
//
//  Created by Ethan Miller on 3/30/14.
//  Copyright (c) 2014 Ethan Miller. All rights reserved.
//

#import "MainMenu.h"
#import "Level1.h"
#import "Character.h"
#import "Tutorial.h"

@implementation MainMenu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Sniglet-Regular"];
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
        
        [self addButtonAtPoint:CGPointMake(900, 300) withText:@"play!" andName:@"play"];
        [self addButtonAtPoint:CGPointMake(900, 200) withText:@"tutorial" andName:@"tutorial"];
        [self addButtonAtPoint:CGPointMake(900, 100) withText:@"credits" andName:@"cred"];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    SKNode *playButton = [self childNodeWithName:@"play"];
    SKNode *credButton = [self childNodeWithName:@"cred"];
    SKNode *tutoButton = [self childNodeWithName:@"tutorial"];
    for (UITouch *touch in touches) {
        CGPoint loc = [touch locationInNode:self];
        if(CGRectContainsPoint([playButton frame], loc)) {
            SKTransition *transition = [SKTransition doorwayWithDuration:0.5];
            transition.pausesIncomingScene = NO;
            transition.pausesOutgoingScene = NO;
            Level1 *l = [[Level1 alloc] initWithSize:CGSizeMake(1024, 768)];
            [self.scene.view presentScene:l transition:transition];
        } else if (CGRectContainsPoint([credButton frame], loc)) {
            UIAlertView *credits = [[UIAlertView alloc] initWithTitle:@"Credits"
                                                              message:@"neko written by Ethan Miller\nneko character and animations public domain\n\n\nCuteness Tester: Eric Richter"
                                                             delegate:nil
                                                    cancelButtonTitle:@"Ok"
                                                    otherButtonTitles:nil];
            [credits show];
        } else if (CGRectContainsPoint([tutoButton frame], loc)) {
            SKTransition *transition = [SKTransition fadeWithDuration:0.0];
            transition.pausesOutgoingScene = NO;
            transition.pausesIncomingScene = NO;
            Tutorial *t = [[Tutorial alloc] initWithSize:CGSizeMake(1024, 768)];
            [self.scene.view presentScene:t transition:transition];
        }
        
        Character *neko = (Character *)[self childNodeWithName:@"neko"];
        [neko moveToPoint:loc];
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
