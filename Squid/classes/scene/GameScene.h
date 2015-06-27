//
//  GameScene.h
//  Squid
//

//  Copyright (c) 2015 Team C. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "constant.h"

@class Monster;
@class Weapon;

@interface GameScene : SKScene

@property (nonatomic, strong) Monster* monster;
@property (nonatomic, strong) SKSpriteNode* cameraNode;
@property (nonatomic, strong) Weapon* weapon_R;
@property (nonatomic, strong) Weapon* weapon_G;
@property (nonatomic, strong) Weapon* weapon_B;
@property (nonatomic, strong) Weapon* weapon_BLACK;

-(void)createBackground;
-(COLOR_DECTION_RESULT) colorDectionResultFromImage:(UIImage *)image;

@end
