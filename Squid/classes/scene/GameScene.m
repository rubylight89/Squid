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
    
    // ball
    [self addBall];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCameraClosed) name:kCameraCloseNotificationName object:nil];
    
    [GameManager sharedManager].takingPhoto = [UIImage imageNamed:@"remi.png"];
    [self handleCameraClosed];
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
    
    CGImageRef imageRef = [GameManager sharedManager].takingPhoto.CGImage;
    
    // データプロバイダを取得する
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    // ビットマップデータを取得する
    CFDataRef dataRef = CGDataProviderCopyData(dataProvider);
    UInt8* buffer = (UInt8*)CFDataGetBytePtr(dataRef);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    int redflag = 0;
    int greenflag = 0;
    int blueflag = 0;
    
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
    }else if(redflag <= greenflag && blueflag <= greenflag){
        NSLog(@"この写真は緑です red:%d green:%d blue:%d",redflag,greenflag,blueflag);
    }else if(redflag <= blueflag && greenflag <= blueflag){
        NSLog(@"この写真は青です red:%d green:%d blue:%d",redflag,greenflag,blueflag);
    }
    
    CFRelease(dataRef);
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)createBackground {
//    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"bg.png"];
//    background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
//    [self addChild:background];
}

-(void)createMonster{
    _monster = [Monster spriteNodeWithImageNamed:@"rabbit.png"];
    [_monster setName:kMonsterNode];
    _monster.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame));
    [self addChild:_monster];
}

-(void)createUI{
    SKSpriteNode *cameraButton = [SKSpriteNode spriteNodeWithImageNamed:@"camera.png"];
    cameraButton.position = CGPointMake(CGRectGetMidX(self.frame), 50);
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


@end
