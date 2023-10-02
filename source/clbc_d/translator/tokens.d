module clbc_d.translator.tokens;

public enum TokenKind {
    COMMAND,
    NUMBER,
    STRING,
    L_BRACE,
    R_BRACE
}

public final class Token {
public:
    const string value;
    const TokenKind kind;

    final this(string value, TokenKind kind) {
        this.value = value;
        this.kind = kind;
    }

    override string toString() const {
        return format("Token(%s, \"%s\")", kind, value);
    }
}
