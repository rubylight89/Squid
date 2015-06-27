//
//  HpBar.h
//  Squid
//
//  Created by Duong Phan on 6/28/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HpBar : SKSpriteNode{
}

//@property (nonatomic, strong) SKSpriteNode* hpNode;
@property (assign) float hpValue;
@property (assign) float hpFull;

- (void)setUpHPBar;
- (void)reduceHPValue:(int)part;
- (void)increaseHPValue:(int)part;

@end
