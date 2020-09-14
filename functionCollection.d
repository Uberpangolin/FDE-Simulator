module functionCollection;

//****************************************

import std.range;
import core.runtime;
import core.thread;
import std.string;
import std.utf;
import std.conv;

auto toUTF16z(S)(S s)
{
    return toUTFz!(const(wchar)*)(s);
}


import core.sys.windows.windef;
import core.sys.windows.winuser;
import core.sys.windows.wingdi;

//*****************************************

import numFunction;

class functionCollection {

	int length;
	numFunction[] functions;

	//CONSTRUCTORS

	this(int length) {
		this.length = length;
		functions = new numFunction[length];
	}

	this() {}

	//GETERS

	int getLength() {
		return this.length;
	}

	numFunction[]* getFunctions() {
		return &functions;
	}

	//MUTEX

	void setLength(int length) {
		this.length = length;
	}

	void setValues(numFunction[] value) {
		this.functions = functions;
	}


	//METHODS

	void defineValues() {

	}


}