package test;
import nanotest.NanoTestRunner;

/**
 * ...
 * @author TABIV
 */
class TestMain
{
    public static function main():Bool
    {
        var runner = new NanoTestRunner();
        
        var doFunctionalTests = true;
        var doStressTests = false;
        
        if (doFunctionalTests)
        {
            runner.add(new TestStructures());
            runner.add(new Test2D());
            runner.add(new Test3D());
            runner.add(new TestMathUtil());
            runner.add(new TestConverters());
            runner.add(new TestFrames());
            runner.add(new TestIntMath());
            runner.add(new TestGeom());
            runner.add(new TestDataStructures());
        }
        
        if (doStressTests)
        {
            runner.add(new TestStress());
        }
        
        return runner.run();
    }
}