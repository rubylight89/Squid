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

#define COLOR_DIF 7
#import "Weapon.h"
#import "HpBar.h"

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
    
    //    [GameManager sharedManager].takingPhoto = [UIImage imageNamed:@"remi.png"];
    
    [self setupVariables];
    // background
    [self createBackground];
    
    // monster
    [self createMonster];
    
    // ui
    [self createUI];
    
    // weapons
    [self createWeapons];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCameraClosed) name:kCameraCloseNotificationName object:nil];
    
    //    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(attackMonster:)]];
}

-(void)setupVariables{
    isDefense=NO;
    turnIndex = 0;
    isPlayerAlive = YES;
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

/* try to test touch bouce
 -(void)attachWeaponToTouch:(UIPanGestureRecognizer *)panGestureRecognizer{
 CGPoint point = [panGestureRecognizer velocityInView:self.view];
 }
 */

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKNode *selectNode = [self nodeAtPoint:location];
        // tap on monster
        if ([selectNode.name compare:kMonsterNode] == NSOrderedSame) {
            
        } else if ([selectNode.name compare:kCameraNode] == NSOrderedSame){
            // open camera
            [self postNotificationAccessCamera];
        }
        
        // tap on weapon
        if ([selectNode isKindOfClass:[Weapon class]]) {
            [self handleWeaponTapped:(Weapon *)selectNode];
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
    // handle camera closed
    if ([GameManager sharedManager].takingPhoto) {
        UIImage *image = [GameManager sharedManager].takingPhoto;
        COLOR_DECTION_RESULT result = [self colorDectionResultFromImage:image];
        switch (result) {
            case RED:{
                [_weapon_R setPictureNode:image];
                [_weapon_R setFrameNode:@"photo_container1"];
                [_weapon_R setColor_result:result];
            }
                break;
                
            case GREEN:{
                [_weapon_G setPictureNode:image];
                [_weapon_G setFrameNode:@"photo_container2"];
                [_weapon_G setColor_result:result];
            }
                break;
                
            case BLUE:{
                [_weapon_B setPictureNode:image];
                [_weapon_B setFrameNode:@"photo_container3"];
                [_weapon_B setColor_result:result];
            }
                break;
                
            case BLACK:{
                [_weapon_BLACK setPictureNode:image];
                [_weapon_BLACK setFrameNode:@"photo_container4"];
                [_weapon_BLACK setColor_result:result];
            }
                break;
                
            default:{
                [_weapon_BLACK setPictureNode:image];
                [_weapon_BLACK setFrameNode:@"photo_container4"];
                [_weapon_BLACK setColor_result:result];
            }
                break;
        }
    }
}

// attact monster
-(void)handleWeaponTapped:(Weapon *)weapon{
    if (turnIndex % 2 != 0 || isPlayerAlive == NO) {
        return;
    }
    
    turnIndex++;
    switch (weapon.color_result) {
        case RED:{
            //reduce enemy blood (devide hp to 6 parts)
            [self.hpEnemyBar reduceHPValue:6];
        }
            break;
            
        case GREEN:{
            //up again
            [self.hpPlayerBar increaseHPValue:6];
        }
            break;
            
        case BLUE:{
            isDefense = YES;
        }
            break;
            
        case BLACK:{
            
        }
            break;
            
        default:
            break;
    }
    
    if (self.hpEnemyBar.size.width <= 0) {
        NSLog(@">>>> monster Die");
        self.monster.isAlive = NO;
        [self flashMessage:@"You win" atPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) duration:2 color:[SKColor whiteColor]];
    }else{
        [self performSelector:@selector(beingAttacted) withObject:nil afterDelay:0.7];
    }
}

-(void)beingAttacted{
    if (turnIndex % 2 == 0 || !self.monster.isAlive) {
        return;
    }
    
    turnIndex++;
    if (isDefense) {
        [self flashMessage:@"MISC" atPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) duration:1 color:[SKColor redColor]];
        isDefense = NO;
    }else{
        [self.hpPlayerBar reduceHPValue:6];
        [self flashMessage:@"Being attated" atPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) duration:1 color:[SKColor redColor]];
    }
    
    if (self.hpPlayerBar.size.width <= 0) {
        NSLog(@">>>> player Die");
        isPlayerAlive = NO;
    }
}

-(void)gameOver{
    [self flashMessage:@"GAME OVER" atPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) duration:2 color:[SKColor redColor]];
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(COLOR_DECTION_RESULT)colorDectionResultFromImage:(UIImage *)image{
    COLOR_DECTION_RESULT result;
    CGImageRef imageRef = image.CGImage;
    
    // データプロバイダを取得する
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    // ビットマップデータを取得する
    CFDataRef dataRef = CGDataProviderCopyData(dataProvider);
    UInt8* buffer = (UInt8*)CFDataGetBytePtr(dataRef);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    int redflag = 0;
    int greenflag = 0;
    int blueflag = 0;
    
    for (int x=0; x<image.size.width; x++) {
        for (int y=0; y<image.size.height; y++) {
            // ピクセルのポインタを取得する
            UInt8*  pixelPtr = buffer + (int)(y) * bytesPerRow + (int)(x) * 4;
            
            // 色情報を取得する
            UInt8 r = *(pixelPtr + 3);  // 赤
            UInt8 g = *(pixelPtr + 2);  // 緑
            UInt8 b = *(pixelPtr + 1);  // 青
            
            int rint = (int)r;
            int gint = (int)g;
            int bint = (int)b;
            
            if(rint-gint  > COLOR_DIF && rint-bint > COLOR_DIF){
                redflag++;
                NSLog(@"赤 %d",redflag);
            }else if(gint-rint > COLOR_DIF && gint-bint > COLOR_DIF){
                greenflag++;
                NSLog(@"緑 %d",greenflag);
            }else if(bint-rint > COLOR_DIF && bint-gint > COLOR_DIF){
                blueflag++;
                NSLog(@"青 %d",blueflag);
            }
            
            NSLog(@"x:%d y:%d R:%d G:%d B:%d", x, y, r, g, b);
        }
    }
    
    if(greenflag <= redflag && blueflag <= redflag){
        NSLog(@"この写真は赤です red:%d green:%d blue:%d",redflag,greenflag,blueflag);
        result = RED;
    }else if(redflag <= greenflag && blueflag <= greenflag){
        NSLog(@"この写真は緑です red:%d green:%d blue:%d",redflag,greenflag,blueflag);
        result = GREEN;
    }else if(redflag <= blueflag && greenflag <= blueflag){
        NSLog(@"この写真は青です red:%d green:%d blue:%d",redflag,greenflag,blueflag);
        result = BLUE;
    }else {
        result = BLACK;
    }
    
    CFRelease(dataRef);
    return result;
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
    
    _hpEnemyBar =  [HpBar spriteNodeWithImageNamed:@"enemy_bar_full"];
    _hpEnemyBar.position = CGPointMake(230, self.frame.size.height - 50);
    [_hpEnemyBar setUpHPBar];
    [self addChild:_hpEnemyBar];
    
    SKSpriteNode* playerText = [SKSpriteNode spriteNodeWithImageNamed:@"player_title"];
    playerText.position = CGPointMake(40, 140);
    [self addChild:playerText];
    
    _hpPlayerBar = [HpBar spriteNodeWithImageNamed:@"player_bar_full"];
    _hpPlayerBar.position = CGPointMake(230, 150);
    [_hpPlayerBar setUpHPBar];
    [self addChild:_hpPlayerBar];
}

-(void)createMonster{
    _monster = [Monster spriteNodeWithImageNamed:@"enemy_default"];
    _monster.isAlive = YES;
    [_monster setName:kMonsterNode];
    _monster.position = CGPointMake(CGRectGetMidX(self.frame),400);
    SKAction *scale1 = [SKAction scaleTo:1.02 duration:1.0];
    SKAction *scale2 =  [SKAction scaleTo:0.98 duration:1.0];
    SKAction *seq1 = [SKAction sequence:@[scale1, scale2]];
    SKAction *fade1 = [SKAction fadeAlphaTo:1.0 duration:1.0];
    SKAction *fade2 =  [SKAction fadeAlphaTo:0.9 duration:1.0];
    SKAction *seq2 = [SKAction sequence:@[fade1, fade2]];
    SKAction *act =[ SKAction group:@[seq1, seq2]];
    SKAction *actr =  [SKAction repeatActionForever:act];
    [_monster runAction:actr];
    [self addChild:_monster];
}

-(void)createUI{
    SKSpriteNode *cameraButton = [SKSpriteNode spriteNodeWithImageNamed:@"photo_btn"];
    cameraButton.position = CGPointMake(CGRectGetMidX(self.frame), 65);
    [cameraButton setName:kCameraNode];
    [self addChild:cameraButton];
}

-(void)createWeapons{
    _weapon_R = [Weapon spriteNodeWithImageNamed:@"photo_container1"];
    [_weapon_R setName:kWeaponR];
    _weapon_R.position = CGPointMake(CGRectGetMidX(self.frame)-140, 200);
    [self addChild:_weapon_R];
    
    _weapon_G = [Weapon spriteNodeWithImageNamed:@"photo_container2"];
    [_weapon_G setName:kWeaponG];
    _weapon_G.position = CGPointMake(CGRectGetMidX(self.frame)-50, 200);
    [self addChild:_weapon_G];
    
    _weapon_B = [Weapon spriteNodeWithImageNamed:@"photo_container3"];
    [_weapon_B setName:kWeaponB];
    _weapon_B.position = CGPointMake(CGRectGetMidX(self.frame)+50, 200);
    [self addChild:_weapon_B];
    
    _weapon_BLACK = [Weapon spriteNodeWithImageNamed:@"photo_container4"];
    [_weapon_BLACK setName:kWeaponBlack];
    _weapon_BLACK.position = CGPointMake(CGRectGetMidX(self.frame)+140, 200);
    [self addChild:_weapon_BLACK];
}

-(void)flashMessage:(NSString *)message atPosition:(CGPoint)position duration:(NSTimeInterval)duration color:(SKColor*)color{
    //a method to make a sprite for a flash message at a certain position on the screen
    //to be used for instructions
    
    //make a label that is invisible
    SKLabelNode *flashLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    flashLabel.position = position;
    flashLabel.fontSize = 40;
    flashLabel.fontColor = color;
    flashLabel.text = message;
    flashLabel.alpha =0;
    flashLabel.zPosition = 100;
    [self addChild:flashLabel];
    //make an animation sequence to flash in and out the label
    SKAction *flashAction = [SKAction sequence:@[
                                                 [SKAction fadeInWithDuration:duration/3.0],
                                                 [SKAction waitForDuration:duration],
                                                 [SKAction fadeOutWithDuration:duration/3.0]
                                                 ]];
    // run the sequence then delete the label
    [flashLabel runAction:flashAction completion:^{[flashLabel removeFromParent];}];
    
}

@end
