//
//  ResizableScene.m
//  SpaceSalad
//
//  Created by Anatoliy Goodz on 9/15/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ResizableScene.h"

@implementation ResizableScene

- (void)didChangeSize:(CGSize)oldSize
{
    CGSize newSize = self.size;
    
    if (!CGSizeEqualToSize(newSize, oldSize))
    {
        SKSpriteNode *background = (SKSpriteNode *)[self childNodeWithName:@"background"];
        background.position = CGPointZero;
        background.size = newSize;
    }
    
    CGAffineTransform transform = CGAffineTransformMakeScale(
        newSize.width / oldSize.width, newSize.height / oldSize.height);
    
    [self enumerateChildNodesWithName:@"*"
        usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
            node.position = CGPointApplyAffineTransform(node.position, transform);
        }];
}

@end
