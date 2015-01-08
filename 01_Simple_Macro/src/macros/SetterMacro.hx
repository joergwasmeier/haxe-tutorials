package macros;

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
using Lambda;

class SetterMacro {
    #if macro
    macro static public function buildIBindable():Array<Field> {
        var fields = Context.getBuildFields();
        var res = [];

        for (o in fields) {
            if (hasBindableMeta(o)) buildField(o, res)
            else res.push(o);
        }

        return res;
    }

    private static function hasBindableMeta(field:Field):Bool {
        for (o in field.meta) {
            if (o.name == ":simpleSetter") return true;
        }

        return false;
    }

    private static function buildField(field:Field, res:Array<Field>):Void {
        switch (field.kind) {
            case FVar(type, expr):
                res.push(field);

                var setterAccess = [Access.APublic];
                var fieldName = field.name;

                field.kind = FProp("default", "set", type, expr);

                var setter = macro function foo(value:$type) {
                    this.$fieldName = value + "MACRO";
                    return value;
                };

                res.push({
                name: 'set_$fieldName',
                kind: FFun(switch (setter.expr) { case EFunction (_, func): func; case _: throw false; }),
                pos: field.pos,
                access: setterAccess
                });

            case _:
                res.push(field);
        }
    }
    #end
}
