package test;

import hxmath.math.Matrix2x2;
import hxmath.math.Matrix3x2;
import hxmath.math.Vector2;
import hxmath.math.Vector3;

class Test2D extends MathTestCase
{
    public function testVector2BasicOps()
    {
        assertTrue(Vector2.xAxis * Vector2.yAxis == 0.0);
        assertTrue(0.0 * Vector2.xAxis == Vector2.zero);
    }
    
    public function testDeterminant()
    {
        assertTrue(Matrix2x2.identity.det == 1.0);
    }
    
    public function testHomogenousTranslation()
    {
        var m = Matrix3x2.identity;
        m.t = new Vector2(3, -1);
        assertTrue(m * Vector2.zero == m.t);
    }
    
    public function testTranspose()
    {
        var m = new Matrix2x2(
            Math.random(), Math.random(),
            Math.random(), Math.random());
        
        var n = m.transpose
            .transpose;
            
        var k = (m - n);
        var normSq = k.a * k.a + k.b * k.b + k.c * k.c + k.d * k.d;
        assertTrue(normSq < 1e-6);
    }
    
    public function testRotation()
    {
        // After 90 degree ccw rotation:
        // x -> +y
        // y -> -x
        assertApproxEquals(((Matrix2x2.rotate(Math.PI / 2.0) * Vector2.xAxis) - Vector2.yAxis).length, 0.0);
        assertApproxEquals(((Matrix2x2.rotate(Math.PI / 2.0) * Vector2.yAxis) + Vector2.xAxis).length, 0.0);
    }
    
    public function testPolarConversion()
    {
        assertApproxEquals(0.0, (Vector2.fromPolar(Math.PI, 1.0) + Vector2.xAxis).length);
        
        // Some backends give +PI, others -PI (they are both equivalent)
        assertApproxEquals(Math.PI, Math.abs((-Vector2.xAxis).angle));
    }
    
    public function testNorms()
    {
        assertTrue(Vector2.yAxis.normal.leftRot * new Vector2(-1, 0) > 0.0);
        assertTrue(Vector2.yAxis.normal.rightRot * new Vector2(-1, 0) < 0.0);
    }
    
    public function testAngles()
    {
        assertApproxEquals(Vector2.yAxis.signedAngleWith(new Vector2(-1, 1)), Math.PI / 4.0);
        assertApproxEquals(Vector2.yAxis.signedAngleWith(new Vector2(1, 1)), -Math.PI / 4.0);
        assertApproxEquals(Vector2.yAxis.signedAngleWith(new Vector2(-1, -1)), 3.0 * Math.PI / 4.0);
        assertApproxEquals(Vector2.yAxis.signedAngleWith(new Vector2(1, -1)), -3.0 * Math.PI / 4.0);
        
        assertApproxEquals(Vector2.yAxis.signedAngleWith(Vector2.xAxis), -Math.PI / 2.0);
        assertApproxEquals(Vector2.xAxis.signedAngleWith(Vector2.yAxis), Math.PI / 2.0);
        
        assertApproxEquals(Vector2.yAxis.angleWith(Vector2.xAxis), Math.PI / 2.0);
        assertApproxEquals(Vector2.xAxis.angleWith(Vector2.yAxis), Math.PI / 2.0);
    }
    
    public function testOrbit()
    {
        for (i in 0...5)
        {
            var center = randomVector2() + new Vector2(1, 1);
            var m:Matrix3x2 = Matrix3x2.orbit(center, Math.PI / 2);
            
            for (j in 0...5)
            {
                var point = randomVector2();
                var pointAfter = m * point;
                assertApproxEquals(0.0, (point - center) * (pointAfter - center));
            }
        }
    }
    
    public function testLinearSubMatrix()
    {
        var m = Matrix3x2.identity;
        m.linearSubMatrix = new Matrix2x2(1.0, 2.0, 3.0, 4.0);
        assertTrue(m.linearSubMatrix == new Matrix2x2(1.0, 2.0, 3.0, 4.0));
    }
}