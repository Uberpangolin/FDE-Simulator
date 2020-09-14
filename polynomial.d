import numFunction;
import std.math;
import std.conv;

/* Polynomial
/  Defined as a series of x^n with a constant out front
/  Has a flag to say if the polynomial is on the denominator
/
*/

class polynomial {

	double[double] polynomial;
	bool denominator = false;
	double power = 1;

	//CONSTRUCTORS

	this() {}

	this(double[double] polynomial) {
		this.polynomial = polynomial;
	}

	this(double constant, double order) {
		this.polynomial[order] = constant;
	}


	//MUTEX

	void setPolynomial(double[double] polynomial) {
		this.polynomial = polynomial;
	}

	//GETTERS

	double[double] getPolynomial() {
		return this.polynomial;
	}

	double getTerm(double order) {
		return polynomial[order]; 
	}

	//METHODS

	void addTerm(double constant, double order) {
		this.polynomial[order] = constant;
	}

	void addTerm(double constant, double order, double power) {
		this.polynomial[order] = constant;
		this.power = power;
	}

	double evaluate(double input) {
		double output = 0;
		foreach(double ord; this.polynomial.byKey()) {
			output += this.polynomial[ord] * pow(input, ord);
		}

		if(this.power != 1) {
			output = pow(output, this.power);
		}
		if(denominator)
			return 1/output;
		else
			return output;
	}


	override string toString() {
		string str = "";
		foreach(double ord; this.polynomial.byKey()) {
			str = str ~ to!string(this.polynomial[ord]) ~ "x^" ~ to!string(ord) ~ " + "; 
		}
		str = str[0 .. $-2];
		if (this.power != 1) {str = "(" ~ str ~ ")^" ~ to!string(this.power);}
		return str;
	}

}