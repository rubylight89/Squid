//
//  Weapon.h
//  Squid
//
//  Created by Duong Phan on 6/28/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "constant.h"

@interface Weapon : SKSpriteNode

@property (nonatomic, strong) SKSpriteNode *frameSprite;

@property (nonatomic, strong) SKSpriteNode *pic;

@property(assign) COLOR_DECTION_RESULT color_result;

- (void)setPictureNode:(UIImage *)image;
- (void)setFrameNode:(NSString *)imageName;

@end
