//
//  GameScene.m
//  Squid
//
//  Created by Duong Phan on 6/27/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import "GameScene.h"
#import "GameManager.h"
#import "Monster.h"

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
    
    // background
    [self createBackground];
    
    // monster
    [self createMonster];
    
    // ui
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCameraClosed) name:kCameraCloseNotificationName object:nil];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(attackMonster:)]];
}

-(void)moveBall:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    //depending on the touch phase do different things to the ball
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        [self attachBallToTouch:pgr];
        
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        [self moveBallToTouch:pgr];
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
//        [self stopMovingTouch:pgr];
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
//        [self stopMovingTouch:pgr];
    }
}

-(void)attachWeaponToTouch:(UIPanGestureRecognizer *)panGestureRecognizer{
     CGPoint point = [panGestureRecognizer velocityInView:self.view];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKNode *selectNode = [self nodeAtPoint:location];
        if ([selectNode.name compare:kMonsterNode] == NSOrderedSame) {
            
        } else if ([selectNode.name compare:kCameraNode] == NSOrderedSame){
            [self postNotificationAccessCamera];
        }
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

-(void)handleCameraClosed {
    // handle camere closed
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)createBackground {

    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"game_bg"];
    background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addChild:background];
    
    SKSpriteNode* enemyBg1 = [SKSpriteNode spriteNodeWithImageNamed:@"enemy_bg1"];
    enemyBg1.position = CGPointMake(CGRectGetMidX(self.frame), 350);
    [self addChild:enemyBg1];
    
    SKSpriteNode* enemyText = [SKSpriteNode spriteNodeWithImageNamed:@"enemy_title"];
    enemyText.position = CGPointMake(40, self.frame.size.height - 50);
    [self addChild:enemyText];
    
    SKSpriteNode* enemyHPBar = [SKSpriteNode spriteNodeWithImageNamed:@"enemy_bar_empty"];
    enemyHPBar.position = CGPointMake(230, self.frame.size.height - 50);
    [self addChild:enemyHPBar];
    
    SKSpriteNode* weapon_1 = [SKSpriteNode spriteNodeWithImageNamed:@"photo_container1"];
    weapon_1.position = CGPointMake(CGRectGetMidX(self.frame)-140, 200);
    [self addChild:weapon_1];
    
    SKSpriteNode* weapon_2 = [SKSpriteNode spriteNodeWithImageNamed:@"photo_container2"];
    weapon_2.position = CGPointMake(CGRectGetMidX(self.frame)-50, 200);
    [self addChild:weapon_2];
    
    SKSpriteNode* weapon_3 = [SKSpriteNode spriteNodeWithImageNamed:@"photo_container3"];
    weapon_3.position = CGPointMake(CGRectGetMidX(self.frame)+50, 200);
    [self addChild:weapon_3];
    
    SKSpriteNode* weapon_4 = [SKSpriteNode spriteNodeWithImageNamed:@"photo_container4"];
    weapon_4.position = CGPointMake(CGRectGetMidX(self.frame)+140, 200);
    [self addChild:weapon_4];
    
    SKSpriteNode* playerText = [SKSpriteNode spriteNodeWithImageNamed:@"player_title"];
    playerText.position = CGPointMake(40, 140);
    [self addChild:playerText];
    
    SKSpriteNode* playerHPBar = [SKSpriteNode spriteNodeWithImageNamed:@"player_bar_empty"];
    playerHPBar.position = CGPointMake(230, 150);
    [self addChild:playerHPBar];
}

-(void)createMonster{
    _monster = [Monster spriteNodeWithImageNamed:@"enemy_default"];
    [_monster setName:kMonsterNode];
    _monster.position = CGPointMake(CGRectGetMidX(self.frame),400);
    [self addChild:_monster];
}

-(void)createUI{
    SKSpriteNode *cameraButton = [SKSpriteNode spriteNodeWithImageNamed:@"photo_btn"];
    cameraButton.position = CGPointMake(CGRectGetMidX(self.frame), 65);
    [cameraButton setName:kCameraNode];
    [self addChild:cameraButton];
}

-(void)createWeapons{
    _weapon = [SKSpriteNode spriteNodeWithImageNamed:@"enemy_default"];
    _weapon.position = CGPointMake(80, 80);
    [self addChild:_weapon];
}

@end
