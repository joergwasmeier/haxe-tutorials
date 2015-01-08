package ;

@:build(macros.SetterMacro.buildIBindable())
class A_01_Setter_Macro {

    // Main static function for haxe (Start point)
    public static function main():Void {
        new A_01_Setter_Macro();
    }


    // Example Metadata
    @:simpleSetter
    private var test:String = "Test";

    // Actual Class Constructor
    public function new() {
        trace("start");

        test = "HelloWorld";
        trace(test);
        
    }
}
