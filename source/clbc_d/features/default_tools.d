module clbc_d.features.default_tools;

import std.array;
import std.format;

import clbc_d.errors;

private class IterBase(T) {
protected:
    T[] _elements;
    size_t _index;
    size_t _length;

    final this(T[] _elements, size_t _length) {
        this._elements = _elements;
        this._length = _length;
    }
}

public final class Iter(T) : IterBase!(T) {
public:
    final this() {
        this([]);
    }

    final this(T[] _elements) {
        super(_elements, _elements.length);
    }

    final this(T[] _elements...) {
        this(array(_elements));
    }

    @property
    T[] elements() {
        return _elements;
    }

    @property 
    size_t length() {
        return _length;
    }

    /++ 
     + Must be checked!
     +/
    T getCurrent(uint forward = 0) const {
        size_t peekingIndex = _index + forward;

        if (peekingIndex >= size_t.max || peekingIndex + 1 >= _length) {
            throw new IndexOutOfBoundsException("Index out of bounds: %d", _index);
        }

        return _elements[peekingIndex];
    }

    override string toString() const {
        string fmt = "Iter[";

        foreach (T element; _elements) {
            string spec = element == getCurrent() ? "->%s<-, " : "%s, "; 
            fmt ~= format(spec, element);
        }

        return fmt[0..$ - 2] ~ "]";
    }
}

unittest {
    Iter!(ubyte) seq_iter = new Iter!(ubyte)(1, 2, 3);
    Iter!(ubyte) arr_iter = new Iter!(ubyte)([1, 2, 3]);

    assert(seq_iter.elements == arr_iter.elements);
    assert(arr_iter.length == arr_iter.length);

    assert(seq_iter.toString() == "Iter[->1<-, 2, 3]");
    assert(arr_iter.toString() == "Iter[->1<-, 2, 3]");
}
