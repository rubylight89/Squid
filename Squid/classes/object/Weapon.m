//
//  Weapon.m
//  Squid
//
//  Created by Duong Phan on 6/28/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon

- (void)setFrameNode:(NSString *)imageName{
    _frameSprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    [self addChild:_frameSprite];
}

- (void)setPictureNode:(UIImage *)image{
    SKTexture *texture = [SKTexture textureWithCGImage:image.CGImage];
    _pic = [SKSpriteNode spriteNodeWithTexture:texture];
    _pic.size = CGSizeMake(self.size.width-10, self.size.height-10);
    [self addChild:_pic];
}

@end
