//
//  GameScene.m
//  SpaceSalad
//
//  Created by Anatoliy Goodz on 9/15/16.
//  Copyright (c) 2016 Anatoliy Goodz. All rights reserved.
//

#import "GameScene.h"

CGFloat RandomForce(CGFloat min, CGFloat max)
{
    return (CGFloat)(arc4random()) * (max - min) / (CGFloat)(UINT_MAX) + min;
}

typedef NS_ENUM(NSInteger, CollisionCategory)
{
    Dish =				0b00000001,
    Floaters =			0b00000010,
    Beaker =			0b00000100,
    EverythingElse =	0b00001000
};

@implementation GameScene

/* Setup your scene here */
-(void)didMoveToView:(SKView *)view
{
//    self.scaleMode = SKSceneScaleModeAspectFill;
    self.size = view.frame.size;
    
//    self.physicsWorld.contactDelegate = self;
    
    SKSpriteNode *backgroundNode = (SKSpriteNode *)[self childNodeWithName:@"background"];
    assert(backgroundNode != nil);
    
    CGFloat scale = view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact ? 0.5 : 1.0;
    
    [self enumerateChildNodesWithName:@"*"
        usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
            if (node != backgroundNode)
            {
                node.xScale = scale;
                node.yScale = scale;
            }
        }
    ];
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithEdgeLoopFromRect:backgroundNode.frame];
    body.categoryBitMask = EverythingElse;
    self.physicsBody = body;
    
    SKSpriteNode *beaker = (SKSpriteNode *)[self childNodeWithName:@"beaker"];
    assert(beaker != nil);
    
    if (beaker.physicsBody == nil)
    {
        CGRect bounds = [self boundsOfSprite:beaker];
        
        CGFloat side = 8.0, base = 6.0;
        
        CGMutablePathRef beakerEdgePath = CGPathCreateMutable();
        CGPathMoveToPoint(beakerEdgePath, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddLineToPoint(beakerEdgePath, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        CGPathAddLineToPoint(beakerEdgePath, nil, CGRectGetMinX(bounds) + side, CGRectGetMaxY(bounds));
        CGPathAddLineToPoint(beakerEdgePath, nil, CGRectGetMinX(bounds) + side, CGRectGetMinY(bounds) + base);
        CGPathAddLineToPoint(beakerEdgePath, nil, CGRectGetMaxX(bounds) - side, CGRectGetMinY(bounds) + base);
        CGPathAddLineToPoint(beakerEdgePath, nil, CGRectGetMaxX(bounds) - side, CGRectGetMaxY(bounds));
        CGPathAddLineToPoint(beakerEdgePath, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        CGPathAddLineToPoint(beakerEdgePath, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithEdgeLoopFromPath:beakerEdgePath];
        body.categoryBitMask = Beaker;
        beaker.physicsBody = body;
    }

    // TODO:
    
    [self enumerateChildNodesWithName:@"veg"
        usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
            SKPhysicsBody *body = node.physicsBody;
            if (body != nil)
            {
                body.categoryBitMask = Floaters;
                body.linearDamping = 0.01;
                body.restitution = 0.1;
                [body applyForce:CGVectorMake(RandomForce(-50.0, 50), RandomForce(-40.0, 40.0))];
                [body applyAngularImpulse:RandomForce(-0.01, 0.01)];
                [body applyImpulse:CGVectorMake(RandomForce(-10.0, 10), RandomForce(-10.0, 10.0))];
            }
    }];
    
    view.ignoresSiblingOrder = YES;
}

/* Called when a touch begins */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.xScale = 0.5;
//        sprite.yScale = 0.5;
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
}

/* Called before each frame is rendered */
-(void)update:(CFTimeInterval)currentTime
{
    
}

- (CGRect)boundsOfSprite:(SKSpriteNode *)sprite
{
    CGRect bounds = sprite.frame;
    CGPoint anchor = sprite.anchorPoint;
    bounds.origin.x = 0.0 - bounds.size.width * anchor.x;
    bounds.origin.y = 0.0 - bounds.size.height * anchor.y;
    
    return bounds;
}

@end
