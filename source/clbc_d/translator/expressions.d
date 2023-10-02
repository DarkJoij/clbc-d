module clbc_d.translator.expressions;

import std.conv;
import std.format;

public enum ExpressionCommandKind {
    DEFINITION,
    ASSIGNMENT,
    OUTPUT,
    NULL
}

public enum CLBC_Type {
    NUMBER,
    STRING,
    IDENTIFIER,
    VOID
}

public enum ExpressionResultKind {
    PRINTABLE,
    VOID,
    NULL
}

public final class ExpressionResult {
public:
    const string result;
    const ExpressionResultKind kind;

    final this(T)(T result) {
        this.result = to!string(result);
        this.kind = ExpressionResultKind.PRINTABLE;
    }

    final this(ExpressionResultKind kind) {
        this.result = "";
        this.kind = kind;
    }

    override string toString() const {
        final switch (kind) {
            case ExpressionResultKind.PRINTABLE:
                return result;
            case ExpressionResultKind.VOID:
                return "VOID";
            case ExpressionResultKind.NULL:
                return "NULL";
        }
    }
}

public interface Expression {
public:
    ExpressionResult execute();
}

public final class DefineExpression {
    
}
