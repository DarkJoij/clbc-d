module clbc_d.features.default_tools;

import std.array;
import std.format;

private class IterBase(T, I) {
protected:
    T[] _elements; // Might be `const` provided?
    I _index;
    size_t _length;

    final this(T[] _elements, size_t _length) {
        this._elements = _elements;
        this._length = _length;
    }

    bool isInRange(I index) const {
        return index < _length;
    }

    @noreturn
    void outOfBounds() const {
        import clbc_d.errors;

        throw new IndexOutOfBoundsException("Index out of bounds: %d", _index);
    }

public:
    void reset() {
        _index = 0;
    }
}

public final class StaticIter(T, I = size_t) : IterBase!(T, I) {  
public:
    final this(T[] _elements) {
        super(_elements, _elements.length);
    }

    final this(T[] _elements...) {
        this(_elements.array);
    }

    @property
    T[] elements() {
        return _elements;
    }

    @property 
    size_t length() {
        return _length;
    }

    T getCurrent(I forward = 0) const {
        auto peekingIndex = cast(I) (_index + forward);

        if (peekingIndex >= I.max || !isInRange(peekingIndex)) {
            outOfBounds();
        }

        return cast(T) _elements[peekingIndex];
    }

    T getNext() {
        ++_index;
        return getCurrent();
    }

    void next() {
        ++_index;

        if (!isInRange(_index)) {
            outOfBounds();
        }
    }

    override string toString() const {
        string fmt = "StaticIter[";

        foreach (element; _elements) {
            string spec = element == getCurrent() ? "->%s<-, " : "%s, "; 
            fmt ~= format(spec, element);
        }

        return fmt[0..$ - 2] ~ "]";
    }
}

unittest {
    alias _Iter = StaticIter!(ubyte, ubyte);

    _Iter seq_iter = new _Iter(1, 2, 3);
    _Iter arr_iter = new _Iter([1, 2, 3]);

    assert(seq_iter.elements == arr_iter.elements);
    assert(arr_iter.length == arr_iter.length);

    seq_iter.next();

    arr_iter.next();
    assert(arr_iter.getNext() == 3);

    assert(seq_iter.toString() == "StaticIter[1, ->2<-, 3]");
    assert(arr_iter.toString() == "StaticIter[1, 2, ->3<-]");
}
