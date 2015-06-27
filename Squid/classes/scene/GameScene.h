//
//  GameScene.h
//  Squid
//

//  Copyright (c) 2015 Team C. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "constant.h"

@class Monster;

@interface GameScene : SKScene

@property (nonatomic, strong) Monster* monster;
@property (nonatomic, strong) SKSpriteNode* cameraNode;

-(void)createBackground;

@end
