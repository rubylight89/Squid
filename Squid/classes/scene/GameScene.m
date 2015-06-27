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
    
    // background
    [self createBackground];
    
    // monster
    [self createMonster];
    
    // ui
    [self createUI];
    
    // ball
    [self addBall];
    
    // weapons
    [self createWeapons];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCameraClosed) name:kCameraCloseNotificationName object:nil];
    
    //    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(attackMonster:)]];
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
    // handle camera closed
    if ([GameManager sharedManager].takingPhoto) {
        UIImage *image = [GameManager sharedManager].takingPhoto;
        COLOR_DECTION_RESULT result = [self colorDectionResultFromImage:image];
        switch (result) {
            case RED:{
                [_weapon_R setPictureNode:image];
                [_weapon_R setFrameNode:@"photo_container1"];
            }
                break;
                
            case GREEN:{
                [_weapon_G setPictureNode:image];
                [_weapon_G setFrameNode:@"photo_container2"];
            }
                break;
                
            case BLUE:{
                [_weapon_B setPictureNode:image];
                [_weapon_B setFrameNode:@"photo_container3"];
            }
                break;
                
            case BLACK:{
                [_weapon_BLACK setPictureNode:image];
                [_weapon_BLACK setFrameNode:@"photo_container4"];
            }
                break;
                
            default:{
                [_weapon_BLACK setPictureNode:image];
                [_weapon_BLACK setFrameNode:@"photo_container4"];
            }
                break;
        }
    }
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
    
    // YUN TEST COLOR
    result = RED;
    return result;
    // YUN TEST COLOR
    
    for (int x=0; x<[GameManager sharedManager].takingPhoto.size.width; x++) {
        for (int y=0; y<[GameManager sharedManager].takingPhoto.size.height; y++) {
            // ピクセルのポインタを取得する
            UInt8*  pixelPtr = buffer + (int)(y) * bytesPerRow + (int)(x) * 4;
            
            // 色情報を取得する
            UInt8 r = *(pixelPtr + 0);  // 赤
            UInt8 g = *(pixelPtr + 1);  // 緑
            UInt8 b = *(pixelPtr + 2);  // 青
            
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
    
    SKSpriteNode* enemyHPBar = [SKSpriteNode spriteNodeWithImageNamed:@"enemy_bar_empty"];
    enemyHPBar.position = CGPointMake(230, self.frame.size.height - 50);
    [self addChild:enemyHPBar];
    
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

- (void)addBall {
    CGFloat radius = 6.0;
    
    SKShapeNode *ball = [SKShapeNode node];
    ball.name = @"ball";
    ball.position = CGPointMake(CGRectGetMidX(self.frame), 150);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 0, 0, radius, 0, M_PI * 2, YES);
    ball.path = path;
    ball.fillColor = [SKColor yellowColor];
    ball.strokeColor = [SKColor clearColor];
    
    CGPathRelease(path);
    
    [self addChild:ball];
}

-(void)createWeapons{
    _weapon_R = [Weapon spriteNodeWithImageNamed:@"photo_container1"];
    _weapon_R.position = CGPointMake(CGRectGetMidX(self.frame)-140, 200);
    [self addChild:_weapon_R];
    
    _weapon_G = [Weapon spriteNodeWithImageNamed:@"photo_container2"];
    _weapon_G.position = CGPointMake(CGRectGetMidX(self.frame)-50, 200);
    [self addChild:_weapon_G];
    
    _weapon_B = [Weapon spriteNodeWithImageNamed:@"photo_container3"];
    _weapon_B.position = CGPointMake(CGRectGetMidX(self.frame)+50, 200);
    [self addChild:_weapon_B];
    
    _weapon_BLACK = [Weapon spriteNodeWithImageNamed:@"photo_container4"];
    _weapon_BLACK.position = CGPointMake(CGRectGetMidX(self.frame)+140, 200);
    [self addChild:_weapon_BLACK];
}

@end
