//
//  HpBar.m
//  Squid
//
//  Created by Duong Phan on 6/28/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import "HpBar.h"

@implementation HpBar

- (void)setUpHPBar{
    self.hpFull = self.size.width;
    self.hpValue = self.hpFull;
}

- (void)reduceHPValue:(int)part{
    self.hpValue =  self.size.width - self.hpFull/part;
    [self setSize:CGSizeMake(self.hpValue, self.size.height)];
}

- (void)increaseHPValue:(int)part{
    self.hpValue =  self.size.width + self.hpFull/part;
    [self setSize:CGSizeMake(self.hpValue, self.size.height)];
}

@end
