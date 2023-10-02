module clbc_d.translator.lexer;

import std.format;

import clbc_d.fmtio;
import clbc_d.translator;

// To separate system and core methods. 
public class LexerTools {
protected:
    InputCode code;
    Token[] tokens;

    final this(InputCode code) {
        this.code = code;
    }

    void addToken(string value, TokenKind kind) {
        tokens ~= new Token(value, kind);
    }

    Instruction peek(size_t forwardOn = 0) {
        try {
            return code.lines.getCurrent(forwardOn);
        } catch (Exception _) {
            return new Instruction();
        }
        
    }

    string next() {
        ++position;
        return peek();
    }
}

public final class Lexer : LexerTools {
public:
    final this(InputCode code) {
        super(code);
    }

    void lex() {
        while (true) {
            Instruction current = peek();

            
        }
    }

    void handleInstruction(Instruction instruction) {
        if (instruction.isInvalid()) {
            
        }

        final switch (instruction.kind) {

        }
    }
}
