//
//  Skill.m
//  Squid
//
//  Created by Duong Phan on 6/27/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import "Skill.h"

@implementation Skill

- (void)setPictureNode:(UIImage *)image{
    SKTexture *texture = [SKTexture textureWithCGImage:image.CGImage];
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:texture];
    [self addChild:sprite];
}

@end
