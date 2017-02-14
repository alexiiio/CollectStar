//
//  GameScene.m
//  SpriteKitTest
//
//  Created by lidi on 2017/2/10.
//  Copyright © 2017年 Li. All rights reserved.
//

#import "GameScene.h"
#import <CoreMotion/CoreMotion.h>

@implementation GameScene {
    int count;
    CMMotionManager *cmManager;
}


- (void)didMoveToView:(SKView *)view {
    // Setup your scene here

    count = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (count>20) {
                [timer invalidate];
            }
            [self createStar];
            count++;
        }];
    
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    

    cmManager = [[CMMotionManager alloc]init];
    cmManager.deviceMotionUpdateInterval = 1/60.0; // 设备运动状态的更新间隔
    [cmManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        self.physicsWorld.gravity = CGVectorMake(motion.gravity.x*9.8*2, motion.gravity.y*9.8*2);
    }];
    
//    [cmManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
//        self.physicsWorld.gravity = CGVectorMake(accelerometerData.acceleration.x*9.8*2, accelerometerData.acceleration.y*9.8*2);
//    }];
    
}
-(void)createStar{
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"star"];
    node.position = CGPointMake(0, self.size.height/2);
    [self addChild:node];
    //创建五角星的路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,0, 50); //1  星星的角
    CGPathAddLineToPoint(path, NULL, 20,20);
    
    CGPathAddLineToPoint(path, NULL, 50,10); // 2
    CGPathAddLineToPoint(path, NULL, 20,-20);
    
    CGPathAddLineToPoint(path, NULL, 30,-50);// 3
    CGPathAddLineToPoint(path, NULL, -20,-20);
    
    CGPathAddLineToPoint(path, NULL, -35,-50); // 4
    CGPathAddLineToPoint(path, NULL, -20,20);
    
    CGPathAddLineToPoint(path, NULL, -50,10); // 5
    
    CGPathCloseSubpath(path);
    node.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path]; // 生成碰撞体积
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered

}

@end
