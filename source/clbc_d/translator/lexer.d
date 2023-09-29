module clbc_d.translator.lexer;

import std.format;

import clbc_d.fmtio;

public enum TokenKind {
    COMMAND,
    NUMBER,
    STRING,
    L_BRACE,
    R_BRACE
}

public final class Token {
public:
    const TokenKind kind;
    const string value;

    final this(TokenKind kind, string value) {
        this.kind = kind;
        this.value = value;
    }

    override string toString() const {
        return format("Token(%s, \"%s\")", kind, value);
    }
}

// To separate system and core methods. 
public class LexerTools {
protected:
    InputCode code;
    size_t position;
    Token[] tokens;

    final this(InputCode code) {
        this.code = code;
    }

    string peek(size_t forwardOn = 0) {
        return ""; // FIXME!
    }
}
