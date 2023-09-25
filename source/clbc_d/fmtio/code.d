module clbc_d.fmtio.code;

import std.array;

public final class ByteCode {
private:
    string innerCode;

public: 
    string[] lines;
    size_t linesCount;

    final this(string code) {
        this.innerCode = code;

        this.lines = code.split("\n");
        this.linesCount = this.lines.length;
    }
}

unittest {
    ByteCode bc = new ByteCode("1\n2");

    assert(bc.lines == ["1", "2"]);
    assert(bc.linesCount == 2);
}
