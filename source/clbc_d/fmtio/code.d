module clbc_d.fmtio.code;

import std.algorithm;
import std.array;
import std.format;
import std.string;

import clbc_d.features;

public enum InstructionKind {
    SINGLE,
    DOUBLE,
    TRIPLE,
    NULL
}

public final class Instruction {
private:
    InstructionKind __kind;
    bool __invalid;
    
    void __makeInvalid() {
        __invalid = true;
    }

public:
    const string 
        command, 
        separator_1, 
        object_1, 
        separator_2, 
        potentialObject_2, 
        separator_3;

    final this() {
        __kind = InstructionKind.NULL;
    }

    final this(string line) {
        __kind = InstructionKind.SINGLE;

        string[] units = line.split(" ")
            .filter!(unit => unit.strip() != "")
            .array;
        
        if (units.length > 6) {
            __makeInvalid();
        }

        if (!__invalid) {
            if (units.length >= 4) {
                command = units[0];
                separator_1 = units[1]; 
                object_1 = units[2]; 
                separator_2 = units[3];

                if (units.length == 6) {
                    potentialObject_2 = units[4];
                    separator_3 = units[5];

                    __kind = InstructionKind.DOUBLE;
                }
            } else {
                __makeInvalid();
            }
        }
    }

    @property
    InstructionKind kind() {
        return __kind;
    }

    bool isInvalid() {
        return __invalid;
    }

    override string toString() const {
        final switch (__kind) {
            case InstructionKind.SINGLE:
                return format("Instruction(\"%s\", %s, \"%s\", %s)",
                    command, separator_1, object_1, separator_2);
            case InstructionKind.DOUBLE:
                return format("Instruction(\"%s\", %s, \"%s\", %s, \"%s\", %s)",
                    command, separator_1, object_1, separator_2, potentialObject_2, separator_3);
            case InstructionKind.TRIPLE:
                return "Not implemented.";
            case InstructionKind.NULL:
                return "NULL";
        }
    }
}

unittest {
    import std.stdio;

    Instruction double_ = new Instruction(" DEF  {  NUMBER  &  x  }");
    Instruction single_ = new Instruction(" PUT  {  x  }");

    assert(double_.command == "DEF");
    assert(double_.separator_1 == "{");
    assert(double_.object_1 == "NUMBER");
    assert(double_.separator_2 == "&");
    assert(double_.potentialObject_2 == "x");
    assert(double_.separator_3 == "}");
    assert(double_.kind == InstructionKind.DOUBLE);
    assert(double_.toString() == "Instruction(\"DEF\", {, \"NUMBER\", &, \"x\", })");

    assert(single_.command == "PUT");
    assert(single_.separator_1 == "{");
    assert(single_.object_1 == "x");
    assert(single_.separator_2 == "}");
    assert(single_.kind == InstructionKind.SINGLE);
    assert(single_.toString() == "Instruction(\"PUT\", {, \"x\", })");
}

public alias Lines = StaticIter!(Instruction, size_t);

public final class InputCode {
private:
    Lines __lines;

public:
    final this(string code) {
        Instruction[] instuctions = code.split("\n")
            .map!(line => new Instruction(line))
            .array;

        this.__lines = new Lines(instuctions);
    }

    @property
    Lines lines() {
        return __lines;
    }

    @property
    size_t length() {
        return __lines.length;
    }

    override string toString() const {
        return format("InputCode(>>> %s)", __lines);
    }
}

unittest {
    InputCode ic = new InputCode("DEF { NUMBER & number }\nSET { x & 10 }");

    Instruction[] __expectedInstructions = [        
        new Instruction("DEF { NUMBER & number }"), 
        new Instruction("SET { x & 10 }")
    ];

    assert(ic.length == 2);
}

public final class OutputCode {
    // FIXME!
}
