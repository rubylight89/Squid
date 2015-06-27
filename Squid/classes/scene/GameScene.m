//
//  GameScene.m
//  Squid
//
//  Created by Duong Phan on 6/27/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import "GameScene.h"
#import "constant.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    /*
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    
    [self addChild:myLabel];
      */
    
    _monster = [SKSpriteNode spriteNodeWithImageNamed:@"rabbit.png"];
    [_monster setName:kMonsterNode];
    _monster.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    [self addChild:_monster];
    
    /*
    SKSpriteNode *cameraButton = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] size:CGSizeMake(100, 80)];
    cameraButton.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 200);
    [cameraButton setName:kCameraNode];
    [self addChild:cameraButton];
    */
    SKLabelNode *cameraLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    cameraLabel.text = @"Camera";
    cameraLabel.fontSize = 20;
    cameraLabel.position = CGPointMake(CGRectGetMidX(self.frame), 50);
    [cameraLabel setName:kCameraNode];
    [self addChild:cameraLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKNode *selectNode = [self nodeAtPoint:location];
        if ([selectNode.name compare:kMonsterNode] == NSOrderedSame) {
            [self postNotificationAccessCamera];
        }
//        if ([_monster containsPoint:location]) {
//            [self postNotificationAccessCamera];
//        }
    }
    
    /*
     SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
     
     sprite.xScale = 0.5;
     sprite.yScale = 0.5;
     sprite.position = location;
     
     SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
     
     [sprite runAction:[SKAction repeatActionForever:action]];
     
     [self addChild:sprite];
     */
    
}

-(void)postNotificationAccessCamera {
    [[NSNotificationCenter defaultCenter] postNotificationName:kCameraAccessNotificationName object:self userInfo:nil];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
