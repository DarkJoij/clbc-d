module clbc_d.errors;

import std.format;

private class CLBCException : Exception {
public:
    final this(T...)(T args) {
        super(format(args));
    }
}

public final class IndexOutOfBoundsException : CLBCException {
public:
    final this(T...)(T args) {
        super(args);
    }
}
