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
@class HpBar;

@interface GameScene : SKScene{
    int turnIndex;
    BOOL isDefense;
    BOOL isPlayerAlive;
}

@property (nonatomic, strong) Monster* monster;
@property (nonatomic, strong) SKSpriteNode* cameraNode;
@property (nonatomic, strong) Weapon* weapon_R;
@property (nonatomic, strong) Weapon* weapon_G;
@property (nonatomic, strong) Weapon* weapon_B;
@property (nonatomic, strong) Weapon* weapon_BLACK;
@property (nonatomic, strong) HpBar* hpEnemyBar;
@property (nonatomic, strong) HpBar* hpPlayerBar;

-(void)createBackground;
-(COLOR_DECTION_RESULT) colorDectionResultFromImage:(UIImage *)image;

@end
