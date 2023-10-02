module clbc_d.translator.parser;

import std.ascii;
import std.format;

import clbc_d.errors;
import clbc_d.fmtio;
import clbc_d.translator;

private CLBC_LanguageObject __defineIdentifier(string identifier) {
    // FIXME!

    return new CLBC_LanguageObject(identifier, CLBC_Type.VOID);
}

private CLBC_LanguageObject __defineConstnatValue(string value) {
    // FIXME!

    return new CLBC_LanguageObject(value, CLBC_Type.VOID);
}

private CLBC_LanguageObject __defineString(string string_) {
    // FIXME!

    return new CLBC_LanguageObject(string_, CLBC_Type.VOID);
}

public final class CLBC_LanguageObject {
public:
    const string value;
    const CLBC_Type type;
    
    final this(string value, CLBC_Type type) {
        this.value = value;
        this.type = type;
    }

    override string toString() const {
        string value_ = type == CLBC_Type.STRING ? format("\"%s\"", value) : value;
        return format("Object(%s, %s)", value_, type);
    }
}

// To separate system and core methods. 
public class ParserTools {
protected:
    InputCode _code;
    Expression[] _expressions;

    final this(InputCode code) {
        this._code = code;
    }

    Instruction _peek(size_t forwardOn = 0) {
        try {
            return _code.lines.getCurrent(forwardOn);
        } catch (Exception _) {
            return new Instruction();
        }
    }
}

public final class Parser : ParserTools {
private:
    Instruction __instruction;

    ExpressionCommandKind __defineCommandKind() {
        switch (__instruction.command) {
            case "DEF":
                return ExpressionCommandKind.DEFINITION;
            case "SET":
                return ExpressionCommandKind.ASSIGNMENT;
            case "PUT":
                return ExpressionCommandKind.OUTPUT;
            default:
                return ExpressionCommandKind.NULL;
        }
    }

    CLBC_LanguageObject __defineObject(string object) {
        char first = object[0];

        if (first.isDigit()) {
            return __defineConstnatValue(object);
        } else if (first == '"') {
            return __defineString(object);
        }

        return __defineIdentifier(object);
    }

public:
    final this(InputCode code) {
        super(code);
        __instruction = _peek();
    }

    void lex() {
        while (true) { 
            // FIXME!
        }
    }

    void lexInstruction() {
        if (__instruction.isInvalid()) {
            throw new SyntaxException("Invalid expression met: %s", __instruction);
        }

        final switch (__instruction.kind) {
            case InstructionKind.SINGLE:
                // FIXME!
                break;
            case InstructionKind.DOUBLE:
                // FIXME!
                break;
            case InstructionKind.TRIPLE:
                // lexTripleInstruction();
                throw new NotImplementedException("Triple expressions are not implemented yet.");
            case InstructionKind.NULL:
                throw new NullableOutputException(
                    "A null expression generated, the program is compiled incorrectly. Please check it again.");
        }
    }

    void lexSingleInstruction() {

    }

    void lexDoubleInstruction() {

    }

    deprecated void lexTripleInstruction() {

    }
}
