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

//****************************************

class numFunction {

	int length;
	double[] value;

	//CONSTRUCTORS

	this(int length) {
		this.length = length;
		value = new double[length];
	}

	this() {}

	//GETERS

	int getLength() {
		return this.length;
	}

	double[]* getValues() {
		return &value;
	}

	//MUTEX

	void setLength(int length) {
		this.length = length;
	}

	void setValues(double[] value) {
		this.value = value;
	}


	//METHODS

	void defineValues() {
		
	}

	void defineValuesCustom(long flag) {
		for(int index = 0; index < length; index++) {
			value[index] = index/10;
		}
	}

}