//
//  Monster.h
//  Squid
//
//  Created by Duong Phan on 6/27/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Monster : SKSpriteNode{
}

@property (assign) BOOL isAlive;

- (void) wait;
- (void) attack;
- (void) hurt;

@end
