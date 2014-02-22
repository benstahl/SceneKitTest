/* =============================================================================
 Struct representing a point with integer values (useful for grid coordinates).
 ============================================================================ */

#import <Foundation/Foundation.h>
#import "inttypes.h"

#ifndef Emerald_AEGeometry_h
#define Emerald_AEGeometry_h

struct AEGridPoint {
	NSInteger x;
	NSInteger y;
};
typedef struct AEGridPoint AEGridPoint;

struct AEGridSize {
	NSUInteger width;
	NSUInteger height;
};
typedef struct AEGridSize AEGridSize;

// Grid points (integer points).
CG_INLINE AEGridPoint AEGridPointMake(NSInteger x, NSInteger y);
CG_INLINE AEGridPoint AEGridPointZero();
CG_INLINE AEGridPoint AEGridPointNotFound();
CG_INLINE BOOL AEGridPointEqualToPoint(AEGridPoint p, AEGridPoint q);
CG_INLINE NSString* NSStringFromAEGridPoint(AEGridPoint p);

// Point, angle, distance, and bearing
CG_INLINE CGFloat AERadToDeg(CGFloat radians);
CG_INLINE CGFloat AEDegToRad(CGFloat degrees);
CG_INLINE CGFloat AENormalize360(CGFloat angle);
CG_INLINE CGFloat AENormalize180(CGFloat angle);
CG_INLINE CGFloat AEAngleDelta(CGFloat angleA, CGFloat angleB);
CG_INLINE CGFloat AEPointsDistance(CGPoint a, CGPoint b);
CG_INLINE CGPoint AEPointsOffset(CGPoint a, CGPoint b);
CG_INLINE CGFloat AEPointsBearing(CGPoint a, CGPoint b);
CG_INLINE CGPoint AEPointFromPointDistanceAngle(CGPoint origin, CGFloat distance, CGFloat angle);

#pragma mark - AEGridPoint

CG_INLINE AEGridPoint AEGridPointMake(NSInteger x, NSInteger y) {
	AEGridPoint p; p.x = x; p.y = y; return p;
}

CG_INLINE AEGridPoint AEGridPointZero() {
	AEGridPoint p; p.x = 0, p.y = 0; return p;
}

CG_INLINE AEGridPoint AEGridPointNotFound() {
	AEGridPoint p; p.x = sizeof(NSUInteger), p.y = sizeof(NSUInteger); return p;
}

CG_INLINE BOOL AEGridPointEqualToPoint(AEGridPoint p, AEGridPoint q) {
	return p.x == q.x && p.y == q.y;
}

CG_INLINE NSString* NSStringFromAEGridPoint(AEGridPoint p) {
	return [NSString stringWithFormat:@"{%@, %@}", @(p.x), @(p.y)];
}

#pragma mark - AEGridSize

CG_INLINE AEGridSize AEGridSizeMake(NSUInteger width, NSUInteger height);
CG_INLINE AEGridSize AEGridSizeZero();

CG_INLINE AEGridSize AEGridSizeMake(NSUInteger width, NSUInteger height) {
	AEGridSize s; s.width = width; s.height = height; return s;
}

CG_INLINE AEGridSize AEGridSizeZero() {
	AEGridSize s; s.width = 0, s.height = 0; return s;
}

#pragma mark - points, angles, bearings, and distance

/* =============================================================================
 Convert radians to degrees.
 ============================================================================ */
CG_INLINE CGFloat AERadToDeg(CGFloat radians) {
	return radians * 180.0 / M_PI;
}

/* =============================================================================
 Convert degrees to radians.
 ============================================================================ */
CG_INLINE CGFloat AEDegToRad(CGFloat degrees) {
	return degrees * M_PI / 180.0;
}

/* =============================================================================
 Normalize an angle to >= 0.0 and < 360.0.
 ============================================================================ */
CG_INLINE CGFloat AENormalize360(CGFloat angle) {
	CGFloat normalizedAngle = fmodf(angle, 360.0);
	if (normalizedAngle >= 360.0) {
		normalizedAngle -= 360.0;
	} else if (normalizedAngle < 0.0) {
		normalizedAngle += 360.0;
	}

	// Make sure angle isn't equal to 360, it whould always be less.
	if (normalizedAngle >= 359.999) {
		normalizedAngle = 0.0;
	}

	return fabsf(normalizedAngle);
}

/* =============================================================================
 Normalize an angle to >= -180.0 and < 180.0.
 ============================================================================ */
CG_INLINE CGFloat AENormalize180(CGFloat angle) {
	CGFloat normalizedAngle = AENormalize360(angle);
	if (normalizedAngle > 180.0) {
		normalizedAngle -= 360.0;
	}

	if (normalizedAngle <= -179.999) {
		normalizedAngle = 180.0;
	}

	return normalizedAngle;
}

/* =============================================================================
 Calculates the signed difference between two angles, deals with wrap-around
 issues. Expects angles in the range of >= 0 to < 360.
 ============================================================================ */
CG_INLINE CGFloat AEAngleDelta(CGFloat angleA, CGFloat angleB) {
	NSCAssert1(angleA >= 0.0 && angleA < 360.0, @"Angle %f is out of allowed range >=0 to <360.", angleA);
	NSCAssert1(angleB >= 0.0 && angleB < 360.0, @"Angle %f is out of allowed range >=0 to <360.", angleB);

	CGFloat delta = angleB - angleA;

	return AENormalize360(delta);
}

/* =============================================================================
 Returns the Eudlidean distance that a point is offset from another point.
 ============================================================================ */
CG_INLINE CGFloat AEPointsDistance(CGPoint a, CGPoint b) {
	CGFloat dx = a.x - b.x;
	CGFloat dy = a.y - b.y;
	return sqrt(dx * dx + dy * dy);
}

/* =============================================================================
 Returns the distance that a point is offset from another point, as separate
 x and y components in a CGPoint.
 ============================================================================ */
CG_INLINE CGPoint AEPointsOffset(CGPoint a, CGPoint b) {
	return CGPointMake(a.x - b.x, a.y - b.y);
}

/* =============================================================================
 Returns an angle representing the direction of a second point relative to the
 first point. Will return an angle between 0 and +360. 0 is "east", positive
 angles are counterclockwise (Sprite Kit system).
 ============================================================================ */
CG_INLINE CGFloat AEPointsBearing(CGPoint a, CGPoint b) {
	CGFloat angleRadians = (atan2((b.y - a.y), (b.x - a.x)));
	return AERadToDeg(angleRadians);
}

/* =============================================================================
 Given a point, an angle from that point, and a distance, returns a new point.
 0 is "east", positive angles are counterclockwise (Sprite Kit system).
 ============================================================================ */
CG_INLINE CGPoint AEPointFromPointDistanceAngle(CGPoint origin, CGFloat distance, CGFloat angle) {
	CGFloat theta = AEDegToRad(angle);
	CGPoint result;
	result.x = origin.x + distance * cos(theta);
	result.y = origin.y + distance * sin(theta);
	return result;
}

#endif
